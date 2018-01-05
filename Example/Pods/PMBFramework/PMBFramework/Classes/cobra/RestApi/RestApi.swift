 //
//  RestApi.swift
//  cobra-iOS
//
//  Created by DickyChengg on 6/19/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import Alamofire
import SwiftyJSON
import RxSwift
import RxCocoa

public class API {
    
    public var baseUrl = ""
    public static let shared = API()
    public static var Key = ""
    
    private var uploadRequest: Request?
    
    private init() {}
    
    public func request(path: String, method: HTTPMethod, parameters: Parameters? = nil, retryAndTimeout: Bool = true, retryOnReachable: Bool = true) -> Observable<JSON> {
        let url = baseUrl + path
                
        let observe = Observable<JSON>.create { (observer) -> Disposable in
            let request = Alamofire.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: self.getDefaultHeaders())
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            request.validate().responseJSON { (response) in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                apiLog(key: "ALAMOFIRE done","\(request.request?.shortUrlString ?? url)\n", param: parameters)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if json["status"].bool ?? true {
                        observer.onNext(json)
                        apiLog(key: "Api Success", json)
                    } else {
                        observer.onError(
                            ApiError(json: json, error: response.error, code: 0)
                        )
                        apiLog(key: "Api Failure", json)
                    }
                    observer.onCompleted()
                case .failure(let errorRequest):
                    var error = ApiError()
                    if let statusCode = response.response?.statusCode {
                        if let data = response.data {
                            error = ApiError(json: JSON(data), error: errorRequest, code: statusCode)
                        } else {
                            apiLog("invalid json")
                        }
                    }
                    observer.onError(error)
                    observer.onCompleted()
                }
            }
            
            return Disposables.create {
                request.cancel()
                
            }
        }
        if retryAndTimeout && retryOnReachable {
            return observe.retry(3).timeout(5, scheduler: MainScheduler.instance).retryOnBecomesReachable(JSON.null, reachabilityService: Dependencies.sharedDependencies.reachabilityService)
        } else if retryOnReachable {
            return observe.retryOnBecomesReachable(JSON.null, reachabilityService: Dependencies.sharedDependencies.reachabilityService)
        } else if retryAndTimeout {
            return observe.retry(3).timeout(5, scheduler: MainScheduler.instance)
        } else {
            return observe
        }
    }
    
    public func upload(image: UIImage, imageKey: String, path: String, method: HTTPMethod, parameters: Parameters? = nil, enableRetry: Bool = true, progress: @escaping ((Float)->Void) = { _ in }) -> Observable<JSON> {
        let url = baseUrl + path
        
        let observe = Observable<JSON>.create { (observer) -> Disposable in
            _ = Alamofire.upload(multipartFormData: { (multipartForm) in
                if let data = UIImageJPEGRepresentation(image, 1) {
                    multipartForm.append(data, withName: imageKey, fileName: "image.jpeg", mimeType: "image/jpeg")
                    for (key, value) in parameters ?? [:] {
                        // autorelease
                        guard let data = String(describing: value).data(using: .utf8, allowLossyConversion: false) else { continue }
                        multipartForm.append(data, withName: key)
                    }
                }
            }, usingThreshold: SessionManager.multipartFormDataEncodingMemoryThreshold,
               to: url,
               method: method,
               headers: self.getDefaultHeaders(upload: true)) { (upload) in
                debug("ALAMOFIRE: request \(url)")
                switch upload {
                case .success(let upload, _, _):
                    
                    self.uploadRequest = upload
                    
                    upload.uploadProgress(closure: { (value) in
                        let current = Float(value.completedUnitCount)
                        let total = Float(value.totalUnitCount)
                        let result = (current / total) * 100
                        progress(result)
                        debug(key: "Upload Progress", result)
                    })
                    
                    upload.responseJSON { response in
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            if json["status"].boolValue {
                                observer.onNext(json)
                                apiLog(key: "Api Success", json)
                            } else {
                                observer.onError(
                                    ApiError(json: json, error: response.error, code: 0)
                                )
                                apiLog(key: "Api Failure", json)
                            }
                            observer.onCompleted()
                        case .failure(let errorRequest):
                            var error = ApiError()
                            if let statusCode = response.response?.statusCode {
                                if let data = response.data {
                                    error = ApiError(json: JSON(data), error: errorRequest, code: statusCode)
                                } else {
                                    apiLog("invalid json")
                                }
                            }
                            observer.onError(error)
                            observer.onCompleted()
                        }
                    }
                    
                case .failure(let error):
                    apiLog(error.localizedDescription)
                    let error = ApiError()
                    error.listArray = [error.localizedDescription]
                    error.statusCode = error._code
                    observer.onError(error)
                }
            }
            return Disposables.create {
                self.uploadRequest?.cancel()
            }
        }
            .timeout(3600, scheduler: MainScheduler.instance)
        if enableRetry {
            return observe.retryOnBecomesReachable(JSON.null, reachabilityService: Dependencies.sharedDependencies.reachabilityService)
        }
        return observe
    }
    
    private func getDefaultHeaders(upload: Bool = false) -> HTTPHeaders {
        var headers: [String : String] = [:]
        headers["Accept"] = "application/json"
        headers["Content-Type"] = (upload ? "multipart-form-data" : "application/x-www-form-urlencoded")
        
        if !String.empty(API.Key) {
            headers["X-API-KEY"] = API.Key
        }
        
        if let loginToken = Keychain.LoginToken.load() {
            headers["Authorization"] = loginToken
        } else {
            guard let permanentToken = Keychain.PermanentToken.load() else {
                return headers
            }
            headers["Authorization"] = permanentToken
        }
        return headers
    }
    
}

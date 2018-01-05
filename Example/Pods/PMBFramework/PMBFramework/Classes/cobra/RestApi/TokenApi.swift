//
//  TokenApi.swift
//  cobra-iOS
//
//  Created by DickyChengg on 5/3/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//


import RxSwift
import SwiftyJSON

class TokenApi {
    
    static var path: String = "token"
    
    static func getPermanentToken(success: @escaping (()->Void), failure: @escaping ((_ error: ApiError)->Void)) -> Disposable {
        var params: [String : String] = [:]
        params["grant_type"] = "client_credentials"
        params["client_id"] = "myawesomeapp"
        params["client_secret"] = "abc123"
        
        return API.shared.request(path: TokenApi.path, method: .post, parameters: params)
            .subscribe(onNext: { (result) in
            Keychain.PermanentToken.save(result["access_token"].stringValue)
            success()
        }, onError: { (error) in
            failure(error as! ApiError)
        }, onCompleted: nil, onDisposed: nil)
    }
    
    class LoginToken {
        
        static func getToken(email: String, password: String, success: @escaping (()->Void), failure: @escaping ((_ error: ApiError)->Void) = { _ in }) -> Disposable {
            var params: [String : Any] = [:]
            params["username"] = email
            params["password"] = password
            return send(withParams: params, success, failure)
        }
        
        static func getGoogleToken(id: String, email: String, success: @escaping (()->Void), failure: @escaping ((_ error: ApiError)->Void) = { _ in }) -> Disposable {
            var params: [String : Any] = [:]
            params["username"] = email
            params["password"] = ""
            params["google_id"] = id
            return send(withParams: params, success, failure)
        }
        
        static func getFacebookToken(id: String, email: String, success: @escaping (()->Void), failure: @escaping ((_ error: ApiError)->Void) = { _ in }) -> Disposable {
            var params: [String : Any] = [:]
            params["username"] = email
            params["password"] = ""
            params["facebook_id"] = id
            return send(withParams: params, success, failure)
        }
        
        
        private static func send(withParams params: [String : Any], _ success: @escaping (()->Void), _ failure: @escaping ((_ error: ApiError)->Void)) -> Disposable {
            var params = params
            params["grant_type"] = "password"
            params["client_id"] = "myawesomeapp"
            params["client_secret"] = "abc123"
            params["scope"] = "trust"
            
            return API.shared.request(path: TokenApi.path, method: .post, parameters: params)
            .subscribe(onNext: { (result) in
                Keychain.LoginToken.save(result["access_token"].stringValue)
                success()
            }, onError: { (error) in
                let error = error as! ApiError
                failure(error)
                debug(error.listString)
            }, onCompleted: nil, onDisposed: nil)
        }
    }
    
}

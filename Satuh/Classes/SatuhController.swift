//
//  SatuhController.swift
//  Pods
//
//  Created by Denny Ong on 9/13/17.
//
//

import UIKit

public struct SatuhUser {
    
    public var id: Int
    public var name: String
    public var email: String
    public var satuh_email: String
    public var location_code: String
    public var phone: String
    public var activation_code: String
    public var active: String
    
    init(_ data: [String : Any]) {
        
        id = data["id"] as? Int ?? 0
        name = data["name"] as? String ?? ""
        email = data["email"] as? String ?? ""
        satuh_email = data["satuh_email"] as? String ?? ""
        location_code = data["location_code"] as? String ?? ""
        phone = data["phone"] as? String ?? ""
        activation_code = data["activation_code"] as? String ?? ""
        active = data["active"] as? String ?? ""
    }
}

public protocol SatuhDelegate: NSObjectProtocol {
    
    func satuh(didLogin: Bool, withUser user: SatuhUser?, error: Error?)
}

public class Satuh {
    
    static var controller = SatuhController()
    
    public static var delegate: SatuhDelegate!
    
    public class var clientID: String {
        get {
            return Satuh.controller.clientID
        }
        set {
            Satuh.controller.clientID = newValue
        }
    }
    
    public class var redirectURI: String {
        get {
            return Satuh.controller.redirectURI
        }
        set {
            Satuh.controller.redirectURI = newValue
        }
    }
    
    public class func presentLoginView(source: UIViewController, animated: Bool, _ completion: (()->Void)?) {
        let nav = UINavigationController(rootViewController: Satuh.controller)
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismiss(_:)))
        Satuh.controller.navigationItem.leftBarButtonItem = doneBtn
        
        source.present(nav, animated: animated) { completion?()
            Satuh.controller.loginWithSatuh()
        }
    }
    
    public class func logoutSatuh() {
        
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                HTTPCookieStorage.shared.deleteCookie(cookie)
            }
        }
    }
    
    @objc class func dismiss(_ sender: Any) {
        Satuh.controller.dismiss(animated: true, completion: nil)
    }
}

class SatuhController: UIViewController {
    
    fileprivate var webController = UIWebView()
    
    fileprivate var loginUrl: String = "https://account.satuh.com/oauth/authorize?"
    fileprivate var loginViewUrl: String = "https://account.satuh.com/login"
    
    var clientID: String = ""
    var redirectURI: String = ""
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view = webController
        
        webController.delegate = self
    }
    
    func loginWithSatuh() {
        
        let url = URL(string: ("\(loginUrl)client_id=\(clientID)&redirect_uri=\(redirectURI)&response_type=token&scope="))
        webController.loadRequest(URLRequest(url: url!))
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

extension SatuhController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let currentUrl = webView.request?.url?.absoluteString
        
        if currentUrl == "https://account.satuh.com/api/user" {
            
            guard let body = webView.stringByEvaluatingJavaScript(from: "document.body.innerHTML")?.replacingOccurrences(of: "<pre style=\"word-wrap: break-word; white-space: pre-wrap;\">", with: "").replacingOccurrences(of: "</pre>", with: ""), let result = convertToDictionary(text: body) else {
                
                Satuh.delegate.satuh(didLogin: false, withUser: nil, error: nil)
                
                webView.loadRequest(URLRequest(url: URL(string: "about:blank")!))
                
                dismiss(animated: true, completion: nil)
                
                return
            }
            
            let user = SatuhUser(result)
            Satuh.delegate.satuh(didLogin: true, withUser: user, error: nil)
            
            webView.loadRequest(URLRequest(url: URL(string: "about:blank")!))
            
            dismiss(animated: true, completion: nil)
            
            return
        }
        
        if currentUrl != loginViewUrl {
            
            var accessToken: String = ""
            
            if (currentUrl!.contains("#access_token")) {
                
                let scanner = Scanner(string: currentUrl!)
                var scanned: NSString?
                
                if scanner.scanUpTo("=", into: nil) {
                    
                    scanner.scanString("=", into: nil)
                    if scanner.scanUpTo("&", into: &scanned) {
                        accessToken = "Bearer \(scanned! as String)"
                    }
                }
                
                guard let url = URL(string: "https://account.satuh.com/api/user") else { return }
                var headers: [String : String] = [:]
                headers["Authorization"] = accessToken
                var request = URLRequest(url: url)
                request.allHTTPHeaderFields = headers
                webController.loadRequest(request)
                
//                Loading Here
                
                return
            }
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        let currentUrl = webView.request?.url?.absoluteString
        
        if currentUrl == "https://account.satuh.com/api/user" {
            
            Satuh.delegate.satuh(didLogin: false, withUser: nil, error: error)
        }
    }
}

//
//  DSource.swift
//  cobra-iOS
//
//  Created by DickyChengg on 3/3/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
//import ReachabilitySwift


// screen for root view
public private(set) var mainScreen = UIScreen.main.bounds

// screenSize for UIElement (subviews of rootView)
// the value still portrait event the view is landscape
var fontSize: CGSize = .zero
public private(set) var screenSize = UIScreen.main.bounds

fileprivate var _apiLog = true
fileprivate var _paramLog = false
fileprivate var _savingLog = false
fileprivate var serverState: ServerStateEn = .beta

public func debug(key: String? = nil, _ variable: Any?, _ isNil: String = "nil") {
    #if DEBUG
        let txt = (key ?? "print") + " :\n \(variable ?? isNil)\n"
        print(txt)
        var log = DebugData.get(key: DSource.debugKey) ?? ""
        log += txt + "\n"
        DebugData.save(log, forKey: DSource.debugKey)
    #endif
}

public func apiLog(key: String? = nil, _ variable: Any?, isNil: String = "nil", param: Any? = nil) {
    guard let param = param else {
        guard _apiLog else { return }
        debug(key: key, variable, isNil)
        return
    }
    debug(key: key, "\(variable ?? "")\(param)", isNil)
}

//open class AppDelegate: UIResponder, UIApplicationDelegate {
//
//    public var window: UIWindow?
//
//}

public class DSource {
    
    private static var workItem: [String : DispatchWorkItem] = [:]
    private static var action: [String : DispatchWorkItem] = [:]
    
    fileprivate static var debugKey: TimeInterval! = Date.currentTimeInterval()
    
    public static var window: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    public static var navbar: UINavigationController? {
        return DSource.window?.rootViewController as? UINavigationController
    }
    
    public static var tabbar: UITabBarController {
        return DSource.navbar?.viewControllers.first as? UITabBarController ?? UITabBarController()
    }
    
    public static var topController: UIViewController? {
        return DSource.navbar?.viewControllers.first
    }
    
    public static func getFromNavStack<Element>() -> Element? {
        return DSource.navbar?.viewControllers.filter({ (vc) -> Bool in
            return vc is Element
        }).first as? Element
    }
    
    public static func redirectToAppStore(withId appId: String, _ completion: @escaping ((_ success: Bool)->Void)) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/bars/id" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
    
    public class func performAction(after delay: Int, with id: String, _ action: @escaping (()->Void)) {
        let item = DispatchWorkItem {
            action()
            DSource.action[id] = nil
        }
        DSource.action[id] = item
        let time = DispatchTime.now() + DispatchTimeInterval.seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: time, execute: item)
    }
    
    public class func cancelPreviousAction(with id: String) {
        DSource.action[id]?.cancel()
        DSource.action[id] = nil
    }
    
    class public func enableConstraintLogging(_ bool: Bool) {
        UserDefaults.standard.set(bool, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        #if RELEASE
            UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        #endif
    }
    
    public class func enableParametersLogging(_ bool: Bool) {
        _paramLog = bool
    }
    
    public class func enableRestApiLogging(_ bool: Bool) {
        _apiLog = bool
    }
    
    public class func enableDebugLogging(_ bool: Bool) {
        if !bool {
            DSource.debugKey = nil
        }
        _savingLog = bool
    }
    
    public class func currentServerState(_ state: ServerStateEn) {
        serverState = state
    }
    
    public class ReachabilityNotifier {
        fileprivate static let data = Reachability()
        
        class func initialize() {
            //            let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            //            NotificationCenter.default.addObserver(appDelegate, selector: #selector(appDelegate.reachabilityChanged(note:)), name: ReachabilityChangedNotification, object: DSource.ReachabilityNotifier.data)
            //            do {
            //                try data?.startNotifier()
            //            } catch {
            //                debug("failed to start reachability")
            //            }
        }
        
        public class var isReachable: Bool {
            if let data = data {
                return !(data.currentReachabilityStatus == .notReachable)
            }
            return false
        }
        
    }
    
    public class Generate {
        
        class var permanentToken: String {
            #if DEBUG
                return DModel.key("permanent-app-debug") + serverState.rawValue
            #else
                return DModel.key("permanent-app-release") + serverState.rawValue
            #endif
        }
        
        class var loginToken: String {
            #if DEBUG
                return DModel.key("login-app-debug") + serverState.rawValue
            #else
                return DModel.key("login-app-release") + serverState.rawValue
            #endif
        }
        
    }
    
    public class func setupFontSize() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        fontSize = UIScreen.main.bounds.size
        if width > height {
            fontSize = CGSize(width: height, height: width)
//            mainScreen.size = fontSize
        }
        screenSize.origin = .zero
        DSource.orientationChanged()
        
        NotificationCenter.default.addObserver(DSource.self, selector: #selector(orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    @objc public class func orientationChanged() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            screenSize.size.width = height
            screenSize.size.height = width
        } else {
            screenSize.size.width = width
            screenSize.size.height = height
        }
    }
}

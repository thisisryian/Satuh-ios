//
//  DModel.swift
//  cobra-iOS
//
//  Created by DickyChengg on 3/4/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//


import SwiftyJSON

public enum DLang: Int {
    case id = -1
    case en = 0
    case ch = 1
}

public class DModel {
    
    public static var SDLang: [String : [String]] = [:]
    
    public static func concat<Key, Value>(_ source: inout [Key: Value], withNewData right: [Key: Value]?) {
        for (key, value) in right ?? [:] {
            source.updateValue(value, forKey: key)
        }
    }
    
    public static var appName: String {
        return Bundle.main.infoDictionary!["CFBundleName"] as! String
    }
    
    public static var applicationName: String = ""
    
    public static func key(_ value: String) -> String {
        return DModel.appName + value
    }
    
    public class func getClipboard() -> String {
        guard UIPasteboard.general.types.count > 0 else {
            return ""
        }
        return UIPasteboard.general.value(forPasteboardType: UIPasteboard.general.types[0]) as? String ?? ""
    }
    
    public class func setClipboard(_ value: String) {
        guard UIPasteboard.general.types.count > 0 else {
            return
        }
        UIPasteboard.general.setValue(value, forPasteboardType: UIPasteboard.general.types[0])
    }
    
}

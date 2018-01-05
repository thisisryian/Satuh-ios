//
//  DebugData.swift
//  PMB iChat
//
//  Created by DickyChengg on 8/26/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

public class DebugData {
    
    public class func get(key: TimeInterval) -> String? {
        return UserDefaults.standard.string(forKey: "\(DModel.applicationName)-DebugData-\(key)-value")
    }
    
    class func save(_ value: String, forKey: TimeInterval) {
        let key = Date.currentTimeInterval()
        save(key: key)
        UserDefaults.standard.set(value, forKey: "\(DModel.applicationName)-DebugData-\(key)-value")
    }
    
    public class var keys: [TimeInterval] {
        return (UserDefaults.standard.string(forKey: "\(DModel.applicationName)-DebugData-keys")?.components(separatedBy: ";") ?? []).map({ (time) in
            return TimeInterval(time) ?? 0
        })
    }
    
    private class func save(key: TimeInterval) {
        var keys = UserDefaults.standard.string(forKey: "\(DModel.applicationName)-DebugData-keys") ?? ""
        keys += ";\(key)"
        UserDefaults.standard.set(keys, forKey: "\(DModel.applicationName)-DebugData-keys")
    }
    
    public class func remove(key: TimeInterval) {
        UserDefaults.standard.set(nil, forKey: "\(DModel.applicationName)-DebugData-keys")
    }
    
    public class func removeAll() {
        for key in DebugData.keys {
            DebugData.remove(key: key)
        }
        UserDefaults.standard.set(nil, forKey: "\(DModel.applicationName)-DebugData-keys")
    }
    
}

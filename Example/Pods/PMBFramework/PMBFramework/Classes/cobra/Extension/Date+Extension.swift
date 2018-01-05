//
//  Date+Extension.swift
//  PMB iChat
//
//  Created by DickyChengg on 8/11/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension Date {
    
    public static func now() -> Date {
        return Date().add(components: [Calendar.Component.hour : 7])
    }
    
    public func now() -> Date {
        return self.add(components: [Calendar.Component.hour : 7])
    }
    
    public static func currentTimeInterval() -> TimeInterval {
        return Date.now().timeIntervalSince1970
    }
    
    public var minGMT7: Date {
        return self.add(components: [Calendar.Component.hour: -7])
    }
    
}

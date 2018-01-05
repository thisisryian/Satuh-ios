//
//  Int+Extension.swift
//  PMB iChat
//
//  Created by DickyChengg on 8/26/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension Int {
    
    public static func random(length len: Int) -> Int {
        let random = arc4random_uniform(9) + 49
        var str = "\(UnicodeScalar(random)!)"
        // autorelease
        for _ in 0..<len-1 {
            let random = arc4random_uniform(10) + 48
            str += "\(UnicodeScalar(random)!)"
        }
        return Int(str)!
    }
    
}

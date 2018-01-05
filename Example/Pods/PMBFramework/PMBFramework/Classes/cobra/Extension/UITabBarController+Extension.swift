//
//  UITabBarController+Extension.swift
//  SGByte-Property
//
//  Created by Laikhoman on 8/24/17.
//  Copyright © 2017 Pundi Mas Berjaya. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    public func get<Element>() -> Element? {
        return viewControllers?.filter({ (vc) -> Bool in
            return vc is Element
        }).first as? Element
    }
    
    public func get<T>(index: Int) -> T? {
        let total = viewControllers?.count ?? 0
        guard index > 0 && index < total else { return nil }
        return viewControllers?[index] as? T
    }
    
}

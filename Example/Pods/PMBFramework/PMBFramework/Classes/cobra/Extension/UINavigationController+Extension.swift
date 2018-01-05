//
//  UINavigationController+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 6/21/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    public func set(titleColor: UIColor, barButtonColor: UIColor, backgroundColor: UIColor) {
        navigationBar.barTintColor = backgroundColor
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: titleColor]
        navigationBar.tintColor = barButtonColor
    }
    
    public func popTo(class controllerClass: AnyClass, animated: Bool) {
        let viewController = viewControllers.filter { (vc) -> Bool in
            return vc.isKind(of: controllerClass)
        }.first
        if let vc = viewController {
            popToViewController(vc, animated: animated)
        }
    }
    
    public func popTo(index: Int, animated: Bool) {
        let loop = viewControllers.count - (index + 2)
        for _ in 0..<loop {
            viewControllers.remove(at: index + 1)
        }
        popViewController(animated: animated)
    }
    
    public func setPreviousViewController(atIndex index: Int) {
        let loop = viewControllers.count - (index + 2)
        for _ in 0..<loop {
            viewControllers.remove(at: index + 1)
        }
    }
    
}

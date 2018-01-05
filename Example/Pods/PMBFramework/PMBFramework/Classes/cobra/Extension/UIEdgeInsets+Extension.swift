//
//  UIEdgeInsets+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/20/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
    
    public init(_ size: CGFloat) {
        left = size
        right = size
        top = size
        bottom = size
    }
    
    public init(horizontal: CGFloat, vertical: CGFloat) {
        left = horizontal
        right = horizontal
        top = vertical
        bottom = vertical
    }
    
    public init(horizontal: CGFloat) {
        left = horizontal
        right = horizontal
        top = 0
        bottom = 0
    }
    
    public init(vertical: CGFloat) {
        left = 0
        right = 0
        top = vertical
        bottom = vertical
    }
    
}

//
//  UITextField+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 3/2/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UITextField {
    
    public convenience init(placeholder: String, color: UIColor = .black) { // color is the textColor
        self.init()
        self.placeholder = placeholder
        self.textColor = color
    }
    
    public func normalTextField(_ borderStyle: UITextBorderStyle, keyboardType: UIKeyboardType = .default, returnKey: UIReturnKeyType = .default, tag: Int = 0) {
        self.borderStyle = borderStyle
        self.keyboardType = keyboardType
        self.returnKeyType = returnKey
        self.autocorrectionType = .no
        self.tag = tag
    }
    
}

//
//  UIButton+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 3/25/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UIButton {
    
    public convenience init(text: String = "", color: UIColor = .black, buttonType: UIButtonType = .system) {
        self.init(type: buttonType)
        self.setTitle(text, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = UIFont.regular(.b1)
    }
    
    public func clearAttributedText() {
        setAttributedTitle(nil, for: .normal)
    }
    
    public func highlightText(withKeyword key: String, match: UIColor, else notMatch: UIColor) {
        let str = (currentTitle ?? "") as NSString
        let attrs = NSMutableAttributedString(string: currentTitle ?? "")
        let range = str.range(of: key, options: .literal, range: NSRange(location: 0, length: str.length))
        if range.length > 0 {
            attrs.addAttributes([NSAttributedStringKey.foregroundColor: match], range: range)
            guard let range = range.toRange() else {
                setAttributedTitle(attrs, for: .normal)
                return
            }
            attrs.addAttributes([NSAttributedStringKey.foregroundColor: notMatch], range: NSRange(location: 0, length: range.lowerBound))
            attrs.addAttributes([NSAttributedStringKey.foregroundColor: notMatch], range: NSRange(location: range.upperBound, length: str.length - range.upperBound))
        }
        setAttributedTitle(attrs, for: .normal)
    }
    
    public func highlightBackground(withKeyword key: String, match: UIColor, else notMatch: UIColor) {
        let str = (currentTitle ?? "") as NSString
        let attrs = NSMutableAttributedString(string: currentTitle ?? "")
        let range = str.range(of: key, options: .literal, range: NSRange(location: 0, length: str.length))
        if range.length > 0 {
            attrs.addAttributes([NSAttributedStringKey.backgroundColor: match], range: range)
            guard let range = range.toRange() else {
                setAttributedTitle(attrs, for: .normal)
                return
            }
            attrs.addAttributes([NSAttributedStringKey.backgroundColor: notMatch], range: NSRange(location: 0, length: range.lowerBound))
            attrs.addAttributes([NSAttributedStringKey.backgroundColor: notMatch], range: NSRange(location: range.upperBound, length: str.length - range.upperBound))
        }
        setAttributedTitle(attrs, for: .normal)
    }
    
}

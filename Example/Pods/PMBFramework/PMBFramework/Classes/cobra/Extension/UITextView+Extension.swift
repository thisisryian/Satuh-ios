//
//  UITextView+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 5/6/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UITextView {
    
    public convenience init(placeholder: String) {
        self.init()
        self.accessibilityLabel = placeholder
        self.text = placeholder
        self.textColor = .lightGray
        self.autocorrectionType = .no
    }
    
    public func normalTextView() {
        self.autocorrectionType = .no
    }
    
    public func clearAttributedText() {
        attributedText = nil
    }
    
    public func highlightText(withKeyword key: String, match: UIColor, else notMatch: UIColor) {
        let str = (text ?? "") as NSString
        let attrs = NSMutableAttributedString(string: text ?? "")
        let range = str.range(of: key, options: .literal, range: NSRange(location: 0, length: str.length))
        if range.length > 0 {
            attrs.addAttributes([NSAttributedStringKey.foregroundColor: match], range: range)
            guard let range = range.toRange() else {
                attributedText = attrs
                return
            }
            attrs.addAttributes([NSAttributedStringKey.foregroundColor: notMatch], range: NSRange(location: 0, length: range.lowerBound))
            attrs.addAttributes([NSAttributedStringKey.foregroundColor: notMatch], range: NSRange(location: range.upperBound, length: str.length - range.upperBound))
        }
        attributedText = attrs
    }
    
    public func highlightBackground(withKeyword key: String, match: UIColor, else notMatch: UIColor) {
        let str = (text ?? "") as NSString
        let attrs = NSMutableAttributedString(string: text ?? "")
        let range = str.range(of: key, options: .literal, range: NSRange(location: 0, length: str.length))
        if range.length > 0 {
            attrs.addAttributes([NSAttributedStringKey.backgroundColor: match], range: range)
            guard let range = range.toRange() else {
                attributedText = attrs
                return
            }
            attrs.addAttributes([NSAttributedStringKey.backgroundColor: notMatch], range: NSRange(location: 0, length: range.lowerBound))
            attrs.addAttributes([NSAttributedStringKey.backgroundColor: notMatch], range: NSRange(location: range.upperBound, length: str.length - range.upperBound))
        }
        attributedText = attrs
    }
    
} 

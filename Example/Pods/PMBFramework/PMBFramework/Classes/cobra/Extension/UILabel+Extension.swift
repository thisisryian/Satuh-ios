//
//  UILabel+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 4/15/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UILabel {
    
    public convenience init(text: String = "", color: UIColor = .black) {
        self.init()
        self.text = text
        self.textColor = color
        self.font = UIFont.regular(.b1)
    }
    
    public func enableEllipsis() {
        adjustsFontSizeToFitWidth = false
        lineBreakMode = .byTruncatingTail
    }
    
    public func setLineHeight(_ height: CGFloat) {
        if let text = self.text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = height
            attributeString.addAttribute(
                NSAttributedStringKey.paragraphStyle,
                value: style,
                range: NSMakeRange(0, text.length)
            )
            self.attributedText = attributeString
        }
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

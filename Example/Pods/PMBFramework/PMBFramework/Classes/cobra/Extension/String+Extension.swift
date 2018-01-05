//
//  String+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/20/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit
import SwiftDate

extension String {
    
    public static func empty(_ value: String?) -> Bool {
        return (value == nil || value!.isEmpty) || (value!.trimmingCharacters(in: NSCharacterSet.whitespaces)).characters.count == 0
    }
    
    public func param(_ values: [String]) -> String {
        var result = self
        // autorelease
        for value in values {
            guard let range = result.range(of: "{i}") else {
                return result
            }
            result = result.replacingCharacters(in: range, with: value)
        }
        
        result = result.replace("{i}", "")
        return result
    }
    
    public func contain(_ str: String) -> Bool {
        return (lowercased().range(of: str) != nil) ? true : false
    }
    
    public func between(min: Int = 0, max: Int) -> Bool {
        return (length >= min && length <= max)
    }
    
    public func replace(_ string: String, _ with: String) -> String {
        return replacingOccurrences(of: string, with: with)
    }
    
    public func replace(_ strings: [String], _ with: String) -> String {
        var text = self
        for str in strings {
            text = text.replace(str, with)
        }
        return text
    }
    
    public func index(of: String, startFrom: Int = 0) -> Int {
        guard let idx = range(of: of)?.lowerBound, startFrom != -1 else {
            return -1
        }
        return distance(from: characters.index(startIndex, offsetBy: startFrom), to: idx)
    }
    
    public func indexes(of: Character) -> [Int] {
        return characters.enumerated().filter {
            $1 == of
        }.map {
            $0.0
        }
    }
    
    public func subStr(_ Start: Int, _ End: Int) -> String {
        let first = characters.index(
            startIndex,
            offsetBy: Start
        )
        
        let last = characters.index(
            endIndex,
            offsetBy: -1 * (length - End)
        )
        
        return String(self[Range(first..<last)])
    }
    
    public var length: Int {
        return characters.count
    }
    
    public var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]{3,}@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    public var isURL: Bool {
        let urlRegEx: String = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let urlTest = NSPredicate(format: "SELF MATCHES %@", urlRegEx)
        return urlTest.evaluate(with: self)
    }
    
    public func html2Attr(_ size: Float = 16) -> NSAttributedString {
        do {
            let html = NSString(string: "<span style=\"font-family: system-light; font-size: \(size)\">" + self + "</span>")
            
            let attr = try NSMutableAttributedString(
                data: (html.replacingOccurrences(of: "\r\n", with: "")).data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!,
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue
                ],
                documentAttributes: nil
            )
            
            return attr
        }
        catch {
            return NSAttributedString(string: "")
        }
    }
    
    public func toDate() -> Date? {
        return self.date(format: .iso8601Auto)?.absoluteDate
    }
    
    public func convertToCurrency(symbol: String? = "") -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = symbol
        return formatter.string(from: NSNumber(value: Int(self) ?? 0))?.replace(".00", "")
    }
    
    public func convertToString() -> String {
        return self.replacingOccurrences(of: ",", with: "")
    }
    
    public static func random(length len: Int) -> String {
        var str = ""
        // autorelease
        for _ in 0..<len {
            let random = arc4random_uniform(26) + 65
            str += "\(UnicodeScalar(random)!)"
        }
        return str
    }
    
}

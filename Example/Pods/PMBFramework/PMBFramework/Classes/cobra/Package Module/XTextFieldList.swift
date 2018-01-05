//
//  XTextFieldList.swift
//  PMB iChat
//
//  Created by DickyChengg on 8/10/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

public class XTextFieldList {
    
    let values: [XTextField]
    
    public init(_ textFields: [XTextField]) {
        values = textFields
    }
    
    public var first: XTextField? {
        return values.first
    }
    
    public var last: XTextField? {
        return values.last
    }
    
    public var total: Int {
        return values.count
    }
    
    public func index(of index: Int) -> XTextField? {
        guard index >= 0 && index < total else {
            fatalError("XTextFieldList: Index must be greater than 0 or the Index is out of range")
        }
        return values[index]
    }
    
    public func get(id: String) -> [XTextField] {
        return values.filter({ (textField) -> Bool in
            return textField.id == id
        })
    }
    
}

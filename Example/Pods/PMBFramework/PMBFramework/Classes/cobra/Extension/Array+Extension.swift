//
//  Array+Extension.swift
//  PMB iChat
//
//  Created by DickyChengg on 9/5/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import Foundation

extension Array {
    
    public mutating func appendFirst(_ value: Element) {
        insert(value, at: 0)
    }
    
    public mutating func append(_ values: [Element]) {
        self += values
    }
    
    public mutating func appendFirst(_ values: [Element]) {
        self = values + self
    }
    
    public func get(_ index: Int, _ null: Element) -> Element {
        guard index >= 0 && index < self.count else {
            return null
        }
        return self[index]
    }
    
}

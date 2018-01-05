//
//  UISegmentedController+Extension.swift
//  Homecity Agency
//
//  Created by DickyChengg on 5/19/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UISegmentedControl {
    
    public func set(selectedColor selected: UIColor, unselectedColor unselected: UIColor) {
        for i in 0..<(subviews.count) {
            self.subviews[i].tintColor = (self.selectedSegmentIndex == i) ? selected : unselected
        }
    }
    
}

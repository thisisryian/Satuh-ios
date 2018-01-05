//
//  UIFont+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/20/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UIFont {
    
    open class func ultraLight(_ style: FontBodyEn) -> UIFont {
        return UIFont.systemFont(
            ofSize: Font.calculate(fontBody: style),
            weight: UIFont.Weight.ultraLight
        )
    }
    
    open class func light(_ style: FontBodyEn) -> UIFont {
        return UIFont.systemFont(
            ofSize: Font.calculate(fontBody: style),
            weight: UIFont.Weight.light
        )
    }
    
    open class func thin(_ style: FontBodyEn) -> UIFont {
        return UIFont.systemFont(
            ofSize: Font.calculate(fontBody: style),
            weight: UIFont.Weight.thin
        )
    }
    
    open class func regular(_ style: FontBodyEn) -> UIFont {
        return UIFont.systemFont(
            ofSize: Font.calculate(fontBody: style),
            weight: UIFont.Weight.regular
        )
    }
    
    open class func medium(_ style: FontHeaderEn) -> UIFont {
        return UIFont.systemFont(
            ofSize: Font.calculate(fontHeader: style),
            weight: UIFont.Weight.medium
        )
    }
    
    open class func semiBold(_ style: FontHeaderEn) -> UIFont {
        return UIFont.systemFont(
            ofSize: Font.calculate(fontHeader: style),
            weight: UIFont.Weight.semibold
        )
    }
    
    open class func bold(_ style: FontHeaderEn) -> UIFont {
        return UIFont.systemFont(
            ofSize: Font.calculate(fontHeader: style),
            weight: UIFont.Weight.bold
        )
    }
    
    open class func heavy(_ style: FontHeaderEn) -> UIFont {
        return UIFont.systemFont(
            ofSize: Font.calculate(fontHeader: style),
            weight: UIFont.Weight.heavy
        )
    }
    
    open class func black(_ style: FontHeaderEn) -> UIFont {
        return UIFont.systemFont(
            ofSize: Font.calculate(fontHeader: style),
            weight: UIFont.Weight.black
        )
    }
    
}

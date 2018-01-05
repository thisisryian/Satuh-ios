//
//  Margin.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/21/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

public struct Margin {
    //Basic
    public static let s4: CGFloat = 4.0
    public static let s8: CGFloat = 8.0
    public static let s12:CGFloat = 12.0
    public static let s16:CGFloat = 16.0
    public static let s24:CGFloat = 24.0
    public static let s32:CGFloat = 32.0
    public static let s40:CGFloat = 40.0
    public static let s44:CGFloat = 44.0
    public static let s48:CGFloat = 48.0
    public static let s56:CGFloat = 56.0
    public static let s64:CGFloat = 64.0
    public static let s96:CGFloat = 96.0
    
    //Button
    public static let b30: CGFloat = 30.0
    public static let b45: CGFloat = 45.0
    public static let b50: CGFloat = 50.0
    
    //Icon
    public static let i10: CGFloat = 10.0
    public static let i15: CGFloat = 15.0
    public static let i20: CGFloat = 20.0
    public static let i25: CGFloat = 25.0
    public static let i30: CGFloat = 30.0
    public static let i35: CGFloat = 35.0
    
    //UIImageView
    public static let m60: CGFloat = 60.0
    public static let m70: CGFloat = 70.0
    public static let m80: CGFloat = 80.0
}


//func UI(_ iPhone: CGFloat, _ iPad: CGFloat? = nil) -> CGFloat {
//    if UIDevice.current.userInterfaceIdiom == .phone || iPad == nil {
//        return iPhone
//    }
//    return iPad!
//}


public func UI<Element>(_ iPhone: Element, _ iPad: Element? = nil) -> Element {
    if UIDevice.current.userInterfaceIdiom == .phone || iPad == nil {
        return iPhone
    }
    return iPad!
}

//
//  Font.swift
//  Cobra
//
//  Created by DickyChengg on 7/24/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

public class Font {
    
    class func calculate(fontHeader header: FontHeaderEn? = nil, fontBody body: FontBodyEn? = nil) -> CGFloat {
        switch (fontSize.height, header?.hashValue ?? -1, body?.hashValue ?? -1) {
        case (XSize.xS, -1, 8), (XSize.S, -1, 8), (XSize.M, -1, 8), (XSize.L, -1, 8), (XSize.xL, -1, 8):
            // f3(5)
            return 9
        case (XSize.xS, -1, 6), (XSize.S, -1, 6),(XSize.M, -1, 6), (XSize.xS, -1, 7), (XSize.S, -1, 7), (XSize.M, -1, 7), (XSize.L, -1, 7):
            // f1(3), f2(4)
            return 10
        case (XSize.xS, -1, 4), (XSize.S, -1, 4), (XSize.M, -1, 4), (XSize.xS, -1, 5), (XSize.S, -1, 5), (XSize.M, -1, 5), (XSize.L, -1, 5), (XSize.L, -1, 6), (XSize.xxL, -1, 8):
            // b5(3), b6(4), f1(1), f3(1)
            return 11
        case (XSize.xS, 5, -1), (XSize.xS, -1, 2), (XSize.xS, -1, 3), (XSize.S, -1, 3), (XSize.M, -1, 3), (XSize.L, -1, 4), (XSize.xL, -1, 7), (XSize.xL, -1, 7):
            // h6(1), b3(1), b4(3), b5(1), f2(1)
            return 12
        case (XSize.xS, 4, -1), (XSize.S, 5, -1), (XSize.xS, -1, 1), (XSize.S, -1, 2), (XSize.L, -1, 3), (XSize.xL, -1, 5), (XSize.xL, -1, 6), (XSize.xxxL, -1, 8):
            // h5(1), h6(1), b2(1), b3(1), b4(1), b6(1), f1(1), f3(1)
            return 13
        case (XSize.xS, 3, -1), (XSize.S, 4, -1), (XSize.M, 5, -1), (XSize.xS, -1, 0), (XSize.S, -1, 1), (XSize.M, -1, 2), (XSize.xL, -1, 4), (XSize.xxL, -1, 7):
            // h4(1), h5(1), h6(1), b1(1), b2(1), b3(1), b5(1), f2(1)
            return 14
        case (XSize.S, 3, -1), (XSize.M, 4, -1), (XSize.L, 5, -1), (XSize.S, -1, 0), (XSize.M, -1, 1), (XSize.L, -1, 2), (XSize.xL, -1, 3), (XSize.xxL, -1, 5), (XSize.xxL, -1, 6):
            // h4(1), h5(1), h6(1), b1(1), b2(1), b3(1), b4(1), b6(1), f1(1)
            return 15
        case (XSize.M, 3, -1), (XSize.L, 4, -1), (XSize.M, -1, 0), (XSize.L, -1, 1), (XSize.xxL, -1, 4), (XSize.xxxL, -1, 7):
            // h4(1), h5(1), b1(1), b2(1), b5(1), f2(1)
            return 16
        case (XSize.xS, 2, -1), (XSize.L, 3, -1), (XSize.xL, 5, -1), (XSize.L, -1, 0), (XSize.xL, -1, 2), (XSize.xxL, -1, 3), (XSize.xxxL, -1, 5), (XSize.xxxL, -1, 6):
            // h3(1), h4(1), h6(1), b1(1), b3(1), b4(1), b6(1), f1(1)
            return 17
        case (XSize.S, 2, -1), (XSize.xL, 4, -1), (XSize.xL, -1, 1), (XSize.xxxL, -1, 4):
            // h3(1), h5(1), b2(1), b5(1)
            return 18
        case (XSize.xS, 1, -1), (XSize.M, 2, -1), (XSize.xL, 3, -1), (XSize.xxL, 5, -1), (XSize.xL, -1, 0), (XSize.xxL, -1, 2), (XSize.xxxL, -1, 3):
            // h2(1), h3(1), h4(1), h6(1), b1(1), b3(1), b4(1)
            return 19
        case (XSize.S, 1, -1), (XSize.L, 2, -1), (XSize.xxL, 4, -1), (XSize.xxL, -1, 1):
            // h2(1), h3(1), h5(1), b2(1)
            return 20
        case (XSize.M, 1, -1), (XSize.xxL, 3, -1), (XSize.xxxL, 5, -1), (XSize.xxL, -1, 0), (XSize.xxxL, -1, 2):
            // h2(1), h4(1), h6(1), b1(1), b3(1)
            return 21
        case (XSize.L, 1, -1), (XSize.xL, 2, -1), (XSize.xxxL, 4, -1), (XSize.xxxL, -1, 1):
            // h2(1), h3(1), h5(1), b2(1)
            return 22
        case (XSize.xxxL, 3, -1),  (XSize.xxxL, -1, 0):
            // h4(1), b1(1)
            return 23
        case (XSize.xL, 1, -1), (XSize.xxL, 2, -1):
            // h2(1), h3(1)
            return 24
        case (XSize.xS, 0, -1):
            // h1
            return 25
        case (XSize.S, 0, -1), (XSize.xxL, 1, -1), (XSize.xxxL, 2, -1):
            // h1(1), h2(1), h3(1)
            return 26
        case (XSize.M, 0, -1):
            // h1
            return 27
        case (XSize.L, 0, -1), (XSize.xxxL, 1, -1):
            // h1(1), h2(1)
            return 28
        case (XSize.xL, 0, -1):
            // h1
            return 30
        case (XSize.xxL, 0, -1):
            // h1
            return 32
        case (XSize.xxxL, 0, -1):
            // h1
            return 34
        default:
            return 18
        }
    }
    
    /*
     device height
     480 :  iPhone 4, 4s
     568 :  iPhone 5 fam, iPhone SE
     667 :  iPhone 6, 6s, 7
     736 :  iPhone 6s+, 7+
     768 :  iPad Mini dkk
     1024:  iPad Pro 9.7
     1366:  iPad Pro 12.9
     */
    
}

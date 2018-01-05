//
//  UIColor+Extension.swift
//  cobra-iOS
//
//  Created by DickyChengg on 2/20/17.
//  Copyright © 2017 DickyChengg. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(hexa: Int) {
        let mask = 0xFF
        let limit: CGFloat = 255.0
        let red = CGFloat((hexa >> 16) & mask) / limit
        let green = CGFloat((hexa >> 8) & mask) / limit
        let blue = CGFloat(hexa & mask) / limit
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    public func alpha(_ value: CGFloat) -> UIColor {
        // displaying a transparent value
        // based on the alpha value that you pass to the function
        // eg: UIColor.black.alpha(0.5)
        return self.withAlphaComponent(value)
    }
    
    open class var primary: UIColor {
        return BaseColor.primary
    }
    
    open class var secondary: UIColor {
        return BaseColor.secondary
    }
    
    open class var background: UIColor {
        // default of background color
        // you can change it to another color
        return UIColor.white
    }
    
    open class var backgroundAlpha: UIColor {
        // like fader but used for background
        return UIColor.grayAlpha.alpha(0.4)
    }
    
    open class var firstGray: UIColor {
        // first dark gray
        return UIColor.init(hexa: 0x353535)
    }
    
    open class var secondGray: UIColor {
        // second dark gray
        return UIColor.init(hexa: 0x555555)
    }
    
    open class var thirdGray: UIColor {
        // first light gray
        return UIColor.init(hexa: 0x757575)
    }
    
    open class var lastGray: UIColor {
        // second light gray
        return UIColor.init(hexa: 0xA5A5A5)
    }
    
    open class var silverGray: UIColor {
        // pure silver color
        return UIColor.init(hexa: 0xF0F0F0)
    }
    
    open class var grayAlpha: UIColor {
        // like fader
        return UIColor.init(red: 0.2, green: 0.2, blue: 0.2, alpha: 0.5)
    }
    
    open class var blackAlpha: UIColor {
        return UIColor.init(hexa: 0xB20000)
    }
    
    public class Main {
        
        open class var red: UIColor {
            return UIColor.init(hexa: 0xFF3B30)
        }
        
        open class var orange: UIColor {
            return UIColor.init(hexa: 0xFF9500)
        }
        
        open class var yellow: UIColor {
            return UIColor.init(hexa: 0xFFCC00)
        }
        
        open class var green: UIColor {
            return UIColor.init(hexa: 0x4CD964)
        }
        
        open class var tealBlue: UIColor {
            return UIColor.init(hexa: 0x5AC8FA)
        }
        
        open class var blue: UIColor {
            return UIColor.init(hexa: 0x007AFF)
        }
        
        open class var purple: UIColor {
            return UIColor.init(hexa: 0x5854D6)
        }
        
        open class var pink: UIColor {
            return UIColor.init(hexa: 0xFF2D55)
        }
    }
    
}

//
//  SDKDefaultColor.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 24/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

extension UIColor {
    class func psdkPrimaryColor() ->  UIColor {
        return UIColor(red:0.776, green:0.09, blue:0.149, alpha:1.0)
    }
    
    class func psdkPrimaryDarkColor() -> UIColor {
        return UIColor(red:0.57, green:0.15, blue:0.00, alpha:1.0)
    }
    
    class func psdkTabSelectedColor() -> UIColor {
        return UIColor(red:0.075, green:0.475, blue:0.753, alpha:1.0)
    }
    
    class func psdkTabUnselectedColor() -> UIColor {
        return UIColor(red:0.996, green:1.000, blue:1.000, alpha:1.0)
    }

    class func psdkTabViewBackgroundColor() -> UIColor {
        return UIColor(red:0.980, green:0.984, blue:0.992, alpha:1.0)
    }
    
    class func pickColor(alphabet: String) -> UIColor {
        let alphabetColors = [0xf16364, 0xf58559, 0xf9a43e, 0xe4c62e, 0x67bf74, 0x59a2be, 0x2093cd, 0xad62a7, 0x5A8770, 0x5a6B9a, 0x6FA9AB, 0xF5AF29, 0x0088B9, 0xF18636, 0xD93A37, 0xA6B12E, 0xF5888D, 0xcb82B5, 0x9A89B5, 0xD33F33, 0xA2B01F, 0xF0B126, 0x0087BF, 0x3ef479, 0xB2B7BB, 0x407887]
        //        let str = String(alphabet).unicodeScalars
        let str = alphabet.unicodeScalars
        let unicode = Int(str[str.startIndex].value)
        if 65...90 ~= unicode {
            let hex = alphabetColors[unicode - 65]
            return UIColor(red: CGFloat(Double((hex >> 16) & 0xFF)) / 255.0, green: CGFloat(Double((hex >> 8) & 0xFF)) / 255.0, blue: CGFloat(Double((hex >> 0) & 0xFF)) / 255.0, alpha: 1.0)
        }
        return UIColor.blackColor()
    }

}
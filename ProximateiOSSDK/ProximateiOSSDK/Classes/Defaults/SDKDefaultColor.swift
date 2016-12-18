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
    
    class func hexToColor(hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        // Convert hex string to an integer
        let hexint = Int(UIColor.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    class func intFromHexString(hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: NSScanner = NSScanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = NSCharacterSet(charactersInString: "#")
        // Scan hex value
        scanner.scanHexInt(&hexInt)
        return hexInt
    }
//    convenience init?(hexString: String) {
//        let r, g, b, a: CGFloat
//        
//        if hexString.hasPrefix("#") {
//            let start = hexString.in(hexString.startIndex, offsetBy: 1)
//            let hexColor = hexString.substringFromIndex(1)
//            
//            if hexColor.characters.count == 8 {
//                let scanner = NSScanner(string: hexColor)
//                var hexNumber: UInt64 = 0
//                
//                if scanner.scanHexInt64(&hexNumber) {
//                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
//                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
//                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
//                    a = CGFloat(hexNumber & 0x000000ff) / 255
//                    
//                    self.init(red: r, green: g, blue: b, alpha: a)
//                    return
//                }
//            }
//        }
//        
//        return nil
//    }

}
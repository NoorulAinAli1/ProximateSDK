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

}
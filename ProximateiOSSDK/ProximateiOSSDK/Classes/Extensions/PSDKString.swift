//
//  PSDKString.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 25/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

extension String {
    
    init(htmlEncodedString: String) {
        let encodedData = htmlEncodedString.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        let attributedString = try? NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
        self.init(attributedString!.string)
    }
    
    
    var localized: String {
        
        var localizedString = NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
        if (localizedString == self) {
            localizedString = NSLocalizedString(self, tableName: nil, bundle: ProximateSDKSettings.getBundle(), value: "", comment: "")
        }
        
        return localizedString
//        return NSLocalizedString(self, tableName: nil, bundle: ProximateSDKSettings.getBundle(), value: "", comment: "")
    }
    
    func localizedWithComment(comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: ProximateSDKSettings.getBundle(), value: "", comment: comment)
    }
    
    func localizedWithValue(value:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: ProximateSDKSettings.getBundle(), value: value, comment: "")
    }
    
    func localizedWithValueAndComment(value:String, andComment comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: ProximateSDKSettings.getBundle(), value: value, comment: comment)
    }
    
    func urlEncoding() -> String {
        return self.stringByReplacingOccurrencesOfString(" ", withString: "%20")//self.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    }

    func mapEncoding() -> String {
        return self.stringByReplacingOccurrencesOfString(" ", withString: "+")
    }
    
    func hexStringFromColor (color : UIColor) -> NSString {
        let components = CGColorGetComponents(color.CGColor)
        
        let r : Float = Float(components[0])
        let g : Float = Float(components[1])
        let b : Float = Float(components[2])
        
        return NSString(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255));
    }

    var numberValue:NSNumber? {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        return formatter.numberFromString(self)
    }
    
}
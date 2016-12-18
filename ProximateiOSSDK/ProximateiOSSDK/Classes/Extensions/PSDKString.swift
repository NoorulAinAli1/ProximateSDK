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

    var numberValue:NSNumber? {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        return formatter.numberFromString(self)
    }
    
}
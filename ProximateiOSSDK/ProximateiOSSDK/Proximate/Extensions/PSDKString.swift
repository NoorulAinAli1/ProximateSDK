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
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
    
    func localizedWithComment(comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: comment)
    }
    
    func localizedWithValue(value:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: value, comment: "")
    }
    
    func localizedWithValueAndComment(value:String, andComment comment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: value, comment: comment)
    }
    
    func urlEncoding() -> String {
        return self.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    }

    
    var numberValue:NSNumber? {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        return formatter.numberFromString(self)
    }
    
}
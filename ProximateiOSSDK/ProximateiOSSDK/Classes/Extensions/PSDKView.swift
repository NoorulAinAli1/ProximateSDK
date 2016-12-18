//
//  PSDKView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 25/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

extension UILabel {
    func setHTMLFromString(text: String, singleLine isSingleLine : Bool = true) {
        let modifiedFont = NSString(format:"<style>b {color: #ae6b0f;}</style><span style=\"font-family: \(self.font!.fontName); font-size: \(self.font!.pointSize)\">%@</span>", text) as String

//        let attrStr = try! NSAttributedString(
//            data: modifiedFont.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
//            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding],
//            documentAttributes: nil)
        let attrStr = try! NSMutableAttributedString(
            data: modifiedFont.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding],
            documentAttributes: nil)
        if isSingleLine {
            let style = NSMutableParagraphStyle()
            style.lineBreakMode = .ByTruncatingTail
            attrStr.addAttributes([ NSParagraphStyleAttributeName: style ],
                                   range: NSMakeRange(0, attrStr.length))
        }
        self.attributedText = attrStr
    }
    
    var sdkFontName : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
    
    var sdkFontSize : CGFloat {
        get { return self.font.pointSize }
        set { self.font = UIFont(name: self.font!.fontName, size: newValue) }
    }
    
//    var substituteFontName : String {
//        get { return self.font.fontName }
//        set {
//            if self.font.fontName.rangeOfString("Medium") == nil {
//                self.font = UIFont(name: newValue, size: self.font.pointSize)
//            }
//        }
//    }
//    
//    var substituteFontNameBold : String {
//        get { return self.font.fontName }
//        set {
//            if self.font.fontName.rangeOfString("Medium") != nil {
//                self.font = UIFont(name: newValue, size: self.font.pointSize)
//            }
//        }
//    }
}

extension UIView {
    
    func borderAndShadow(){
        self.layer.masksToBounds = false
        self.backgroundColor = UIColor.whiteColor()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = 4
    
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(0, 4);
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 2;
    }
    
    func slideInFromRight(duration: NSTimeInterval = 0.65, completionDelegate: AnyObject? = nil) {
       
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .CurveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransformMakeTranslation(0, 0.0)
            }, completion: { (finished) -> Void in
                //                self.removeFromSuperview()
                
        })
//        // Create a CATransition animation
//        let slideInFromRightTransition = CATransition()
//        
//        // Set its callback delegate to the completionDelegate that was provided (if any)
//        if let delegate: AnyObject = completionDelegate {
//            slideInFromRightTransition.delegate = delegate
//        }
//        
//        // Customize the animation's properties
//        slideInFromRightTransition.type = kCATransitionPush
//        slideInFromRightTransition.subtype = kCATransitionFromRight
//        slideInFromRightTransition.duration = duration
//        slideInFromRightTransition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
//        slideInFromRightTransition.fillMode = kCAFillModeRemoved
//        
//        // Add the animation to the View's layer
//        self.layer.addAnimation(slideInFromRightTransition, forKey: "slideInFromRightTransition")
    }
    
    func slideOutFromRight(duration: NSTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {

        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: .CurveEaseOut, animations: { () -> Void in
            self.transform = CGAffineTransformMakeTranslation(self.frame.width, 0.0)
            }, completion: { (finished) -> Void in
//                self.removeFromSuperview()
               
        })
    }
}
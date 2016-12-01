//
//  PSDKView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 25/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

extension UIImage {
//    func averageImageColor() -> UIColor {
//        let midWidth    = self.size.width/2
//        let midHeight   = self.size.height/2
//        
//        let rgba = UnsafeMutablePointer<CUnsignedChar>.alloc(4)
//        let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
//        let info = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
//        let context: CGContextRef = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, info.rawValue)!
//        
//        CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), self.CGImage)
////        CGContextDrawImage(context, CGRectMake(midWidth-1, midHeight-1, midWidth, midHeight), self.CGImage)
//        
//        if rgba[3] > 0 {
//            let alpha: CGFloat = CGFloat(rgba[3]) / 255.0
//            let multiplier: CGFloat = alpha / 255.0
//            return UIColor(red: CGFloat(rgba[0]) * multiplier, green: CGFloat(rgba[1]) * multiplier, blue: CGFloat(rgba[2]) * multiplier, alpha: alpha)
//        } else {
//            return UIColor(red: CGFloat(rgba[0]) / 255.0, green: CGFloat(rgba[1]) / 255.0, blue: CGFloat(rgba[2]) / 255.0, alpha: CGFloat(rgba[3]) / 255.0)
//        }
//    }

}
extension UIImageView {
    override func borderAndShadow() {
//        let path = UIBezierPath(roundedRect:self.bounds, byRoundingCorners:[.TopRight, .BottomLeft], cornerRadii: CGSizeMake(20, 20))
//        let maskLayer = CAShapeLayer()
//        
//        maskLayer.path = path.CGPath
//        self.layer.mask = maskLayer
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(4, 10);
        self.layer.shadowRadius = 6;
        self.layer.shadowOpacity = 4;
    }
}

extension UIView {
    
    func borderAndShadow(){
        self.layer.masksToBounds = false
        self.backgroundColor = UIColor.whiteColor()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.cornerRadius = 10
    
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSizeMake(0, 4);
        self.layer.shadowRadius = 4;
        self.layer.shadowOpacity = 2;
    }
    
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
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
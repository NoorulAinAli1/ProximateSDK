//
//  UIImageFilter.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 21/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit

extension UIImage {
    
    func resizeImage()->UIImage{
        let size = CGSizeApplyAffineTransform(self.size, CGAffineTransformMakeScale(0.3, 0.3))
        let hasAlpha = false
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
        self.drawInRect(CGRect(origin: CGPointZero, size: size))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
        
    }
    
    func rotateImage() -> UIImage {
        
        if (self.imageOrientation == UIImageOrientation.Up ) {
            return self
        }
        
        UIGraphicsBeginImageContext(self.size)
        
        self.drawInRect(CGRect(origin: CGPoint.zero, size: self.size))
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!

    }
    
    func grayImage()-> UIImage {
        // create a CGRect representing the full size of our input iamge
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        // figure out the height of one section (there are six)
        let sectionHeight = self.size.height / 6
        
        // set up the colors – these are based on my trial and error
        let gray = UIColor.darkGrayColor().CGColor
        let colors = [gray]
        
        // set up our drawing context
        UIGraphicsBeginImageContextWithOptions(self.size, true, 0)
        let context = UIGraphicsGetCurrentContext()
        
        // fill the background with white so that translucent colors get lighter
        CGContextSetFillColorWithColor(context!, UIColor.whiteColor().CGColor)
        CGContextFillRect(context!, rect)
        
        // loop through all six colors
        //        for i in 0 ..< colors.count {
        let color = colors[0]//colors[i]
        
        // figure out the rect for this section
        let rect2 = CGRect(x: 0, y: 0 * sectionHeight, width: rect.width, height: sectionHeight)
        
        // draw it onto the context at the right place
        CGContextSetFillColorWithColor(context!, color)
        CGContextFillRect(context!, rect2)
        //        }
        
        // now draw our input image over using Luminosity mode, with a little bit of alpha to make it fainter
        self.drawInRect(rect, blendMode: .Luminosity, alpha: 1)//0.6)
        
        // grab the finished image and return it
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
        
    }
    
    class func imageWithColor(color: UIColor, size: CGSize) -> UIImage {
        let rect: CGRect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    class func scaleDownWithNewSize(newSize : CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, true, 0.0)
        let alpha = CGFloat(1)
//        self.drawInRect(rect, blendMode: .Luminosity, alpha: alpha)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}

public struct GrayImageFilter: ImageFilter {
    
    /// The filter closure used to create the modified representation of the given image.
    public var filter: Image -> Image {
        return { image in
            return image.grayImage()
        }
    }
}

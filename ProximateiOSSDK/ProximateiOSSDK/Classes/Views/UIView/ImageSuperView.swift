//
//  ImageSuperView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 27/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class ImageSuperView: UIView {
    
    private var bgColor         : UIColor!  = UIColor.whiteColor()
    private var shadowColor     : UIColor!  = UIColor.grayColor()
    private var shadowOffset    : CGSize!   = CGSizeMake(0, 2)
    private var borderWidth     : CGFloat!  = 1.0
    private var borderColor     : UIColor!  = UIColor.clearColor()
    private var cornerRadius    : CGFloat!  = 4.0
    private var shadowRadius    : CGFloat!  = 4.0
    private var shadowOpacity   : Float     = 2.0

    var imageLayer: CALayer!
    var image: UIImage? {
        didSet { refreshImage() }
    }

    override init(frame : CGRect){
        super.init(frame: frame)
    }
    
    //    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    //        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    //        // Custom initialization
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func intrinsicContentSize() -> CGSize {
        return self.bounds.size
    }
    
    func refreshImage() {
        if let imageLayer = imageLayer, image = image {
            imageLayer.contents = image.CGImage
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        if imageLayer == nil {
//            let radius: CGFloat = 6, offset: CGFloat = 4
//            
//            let shadowLayer = CALayer()
//            shadowLayer.shadowColor = UIColor.blackColor().CGColor
//            shadowLayer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).CGPath
//            shadowLayer.shadowOffset =  CGSize(width: offset, height: offset)//CGSizeMake(4, 10)//
//            shadowLayer.shadowOpacity = 4//0.95
//            shadowLayer.shadowRadius = 4
//            layer.addSublayer(shadowLayer)
//            
//            let maskLayer = CAShapeLayer()
//            maskLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).CGPath
//            
//            imageLayer = CALayer()
//            imageLayer.mask = maskLayer
//            imageLayer.frame = self.bounds
//            imageLayer.backgroundColor = UIColor.whiteColor().CGColor
//            imageLayer.contentsGravity = kCAGravityResizeAspect//kCAGravityResizeAspectFill
//            layer.addSublayer(imageLayer)
//        }
        
        let options = ProximateSDKSettings.getCardOptions()
//        for option in options {
//            switch (option) {
//            case let .CardBackgroundColor(value):
//                bgColor = value
//            case let .CardShadowColor(value):
//                shadowColor = value
//            case let .CardShadowOffset(value):
//                shadowOffset = value
//            case let .CardCornerRadius(value):
//                cornerRadius = value
//            case let .CardShadowRadius(value):
//                shadowRadius = value
//            case let .CardShadowOpacity(value):
//                shadowOpacity = value
//            case let .CardBorderWidth(value):
//                borderWidth = value
//            case let .CardBorderColor(value):
//                borderColor = value
//            default: break
//            }
//        }
        
        if imageLayer == nil {
            
            let shadowLayer = CALayer()
            shadowLayer.shadowColor = shadowColor.CGColor
            shadowLayer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).CGPath
            shadowLayer.shadowOffset =  shadowOffset
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            layer.addSublayer(shadowLayer)
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: CGRectInset(self.bounds, 2.0, 2.0), cornerRadius: cornerRadius).CGPath
            
            imageLayer = CALayer()
            imageLayer.mask = maskLayer
            imageLayer.frame = self.bounds
            imageLayer.backgroundColor = bgColor.CGColor
            imageLayer.borderColor = borderColor.CGColor
            imageLayer.borderWidth = borderWidth
            imageLayer.contentsGravity = kCAGravityResizeAspect//kCAGravityResizeAspectFill
            layer.addSublayer(imageLayer)
        }
        refreshImage()
    }

}

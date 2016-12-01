//
//  ImageSuperView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 27/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class ImageSuperView: UIView {
    
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
        
        if imageLayer == nil {
            let radius: CGFloat = 6, offset: CGFloat = 4
            
            let shadowLayer = CALayer()
            shadowLayer.shadowColor = UIColor.blackColor().CGColor
            shadowLayer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).CGPath
            shadowLayer.shadowOffset =  CGSize(width: offset, height: offset)//CGSizeMake(4, 10)//
            shadowLayer.shadowOpacity = 4//0.95
            shadowLayer.shadowRadius = 4
            layer.addSublayer(shadowLayer)
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).CGPath
            
            imageLayer = CALayer()
            imageLayer.mask = maskLayer
            imageLayer.frame = self.bounds
            imageLayer.backgroundColor = UIColor.whiteColor().CGColor
            imageLayer.contentsGravity = kCAGravityResizeAspect//kCAGravityResizeAspectFill
            layer.addSublayer(imageLayer)
        }
        
        refreshImage()
    }

}

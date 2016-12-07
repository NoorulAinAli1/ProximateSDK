//
//  ImageCenterButton.swift
//  Pods
//
//  Created by NoorulAinAli on 07/12/2016.
//
//

import UIKit

@IBDesignable
class ImageCenterButton: UIButton {
    let IMAGECENTERBUTTON_IMAGE_TEXT_SPACING : CGFloat   = 10.0
    let IMAGECENTERBUTTON_TITLE_MIN_HEIGHT : CGFloat     = 14.0
    let IMAGECENTERBUTTON_PADDING_MIN : CGFloat        = 8.0

    // Round Image
    @IBInspectable var imageIsRound : Bool?
    
    // Image Padding
    @IBInspectable var padding : CGFloat?
    // Border width
    @IBInspectable var borderWidth  : CGFloat?
    
    // Spacing between imageview and textlabel
    @IBInspectable var imageTextSpace : CGFloat?
    // Maximum imageview size
    @IBInspectable var imageViewMaxSize : CGSize?
    // Button backgroundHighlighted
    @IBInspectable var backgroundHighlightedColor : UIColor?
    // Button backgroundNormal
    @IBInspectable var backgroundNormalColor : UIColor?
    // Border Color
    @IBInspectable var borderColor : UIColor?
    
//    override init(){
//        super.init()
//        self.addAction()
//    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.addAction()
    }
    
    override func awakeFromNib() {
        self.addAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addAction()
    }
    
    func addAction() {
        self.addTarget(self, action: #selector(pressed(_:)), forControlEvents: UIControlEvents.TouchDown)
        self.addTarget(self, action: #selector(touchUp(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.addTarget(self, action: #selector(touchUp(_:)), forControlEvents: UIControlEvents.TouchUpOutside)
        self.addTarget(self, action: #selector(touchUp(_:)), forControlEvents: UIControlEvents.TouchCancel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.adjustsImageWhenHighlighted = false

        if (self.padding == nil) {
            self.padding = IMAGECENTERBUTTON_PADDING_MIN
        }

        if (self.imageTextSpace == nil) {
            self.imageTextSpace = IMAGECENTERBUTTON_IMAGE_TEXT_SPACING
        }

        var titleLabelHeight : CGFloat = self.titleLabel!.frame.size.height
        if (titleLabelHeight == 0) {
            titleLabelHeight = IMAGECENTERBUTTON_TITLE_MIN_HEIGHT
        }

        var imageMaxHeight : CGFloat = self.frame.size.height - titleLabelHeight - self.imageTextSpace! - self.padding! * 2;
        var imageMaxWidth : CGFloat = self.frame.size.width - self.padding! * 2;

        if ((self.imageViewMaxSize?.height) != nil) {
            imageMaxHeight = self.imageViewMaxSize!.height;
        }
        
        if ((self.imageViewMaxSize?.width) != nil) {
            imageMaxWidth = self.imageViewMaxSize!.width;
        }

//        // Set ImageView Threshold
        if (self.imageView!.frame.size.height > imageMaxHeight) {
            var newImageView  = self.imageView!.frame
            newImageView.size = CGSizeMake(imageMaxHeight / self.imageView!.frame.size.height * self.imageView!.frame.size.width, imageMaxHeight)
            self.imageView!.frame = newImageView
        }

        if (self.imageView!.frame.size.width > imageMaxWidth) {
            var newImageView = self.imageView!.frame
            newImageView.size = CGSizeMake(imageMaxWidth , imageMaxWidth / self.imageView!.frame.size.width * self.imageView!.frame.size.height)
            self.imageView!.frame = newImageView
        }

        var totalHeight : CGFloat = self.imageView!.frame.size.height + self.imageTextSpace! + titleLabelHeight
    
        //Center image
        var center : CGPoint = self.imageView!.center
        center.x = self.frame.size.width / 2.0;
        center.y = self.frame.size.height / 2.0 - totalHeight / 2.0 + self.imageView!.frame.size.height / 2.0
        self.imageView!.center = center
        
        if (self.imageIsRound != nil) {
            self.imageView!.layer.cornerRadius = self.imageView!.frame.size.width / 2.0;
        }
    
        var titleLabelFrame : CGRect = self.titleLabel!.frame
        titleLabelFrame.size = CGSizeMake(self.frame.size.width, titleLabelHeight)
        self.titleLabel?.frame = titleLabelFrame;
        
        //Center text
        var titleCenter : CGPoint = self.titleLabel!.center
        titleCenter.x = self.frame.size.width / 2.0
        titleCenter.y = self.imageView!.center.y + self.imageView!.frame.size.height / 2.0 + self.imageTextSpace! + titleLabelHeight / 2.0
        self.titleLabel?.center = titleCenter;
        
        self.titleLabel?.textAlignment = .Center

        if (self.borderWidth != nil) {
            self.layer.borderWidth = self.borderWidth!
        }
        
        if (self.borderColor != nil) {
            self.layer.borderColor = self.borderColor!.CGColor
        }
    }
    
    func pressed(btn : UIButton){
        if (self.backgroundHighlightedColor != nil) {
            self.backgroundColor = self.backgroundHighlightedColor
        } else {
            btn.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha:0.2)
        }
    }
    
    func touchUp(btn : UIButton){
        if (self.backgroundNormalColor != nil) {
            self.backgroundColor = self.backgroundNormalColor
        } else {
            btn.backgroundColor = UIColor.clearColor()
        }
    }
}

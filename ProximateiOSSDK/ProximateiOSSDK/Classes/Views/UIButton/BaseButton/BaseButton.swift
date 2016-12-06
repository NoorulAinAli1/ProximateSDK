//
//  BaseButton.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 02/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class BaseButton: UIButton {
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.customize()
    }
    
    override func awakeFromNib() {
        self.customize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customize()
    }
    
    private func customize(){
//        self.titleLabel?.font = UIFont(name: AppConstants.kAppNormalFontName, size: 12.0)
        self.titleLabel?.textColor = UIColor.whiteColor()
        self.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal);
        self.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted);
//        self.backgroundColor = UIColor.buttonBgStartColor()
        self.clipsToBounds = true
        
        self.layer.borderWidth = 0.8
        self.layer.borderColor = UIColor.psdkPrimaryDarkColor().CGColor
        self.layer.cornerRadius = 4///self.frame.size.height/2
        
        self.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled);
     
        setAppThemeGradientLayer()
    }
    
    private func setAppThemeGradientLayer(){
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPointMake(0.0,0.0)
        layer.cornerRadius = 4///self.frame.size.height/2
        
        layer.colors = [UIColor.psdkPrimaryColor().CGColor, UIColor.psdkPrimaryDarkColor().CGColor]
        self.layer.insertSublayer(layer, atIndex: 0)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

}

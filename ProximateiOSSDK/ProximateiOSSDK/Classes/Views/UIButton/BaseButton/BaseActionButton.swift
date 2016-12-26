//
//  BaseActionButton.swift
//  Pods
//
//  Created by NoorulAinAli on 13/12/2016.
//
//

import UIKit

class BaseActionButton : BaseButton {
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }

    override func awakeFromNib() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func customize(){
        self.userInteractionEnabled = true
        self.titleLabel?.textColor = ProximateSDKSettings.psdkCardOptions.cardBackgroundColor
        self.setTitleColor(ProximateSDKSettings.psdkCardOptions.cardBackgroundColor, forState: UIControlState.Normal);
        self.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted);
        self.clipsToBounds = true

        self.layer.borderWidth = 0.8
        self.layer.borderColor = ProximateSDKSettings.psdkViewOptions.primaryDarkColor.CGColor
        self.layer.cornerRadius = ProximateSDKSettings.psdkCardOptions.cardCornerRadius

        self.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Disabled);

        setAppThemeGradientLayer()
        setStyle(ProximateSDKSettings.psdkCardOptions.cardBackgroundColor, size: ProximateSDKSettings.psdkFontOptions.campaignDetailTextSize)

    }

    private func setAppThemeGradientLayer(){
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPointMake(0.0,0.0)
        layer.cornerRadius = ProximateSDKSettings.psdkCardOptions.cardCornerRadius

        layer.colors = [ProximateSDKSettings.psdkViewOptions.primaryColor.CGColor, ProximateSDKSettings.psdkViewOptions.primaryDarkColor.CGColor]
        self.layer.insertSublayer(layer, atIndex: 0)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

}

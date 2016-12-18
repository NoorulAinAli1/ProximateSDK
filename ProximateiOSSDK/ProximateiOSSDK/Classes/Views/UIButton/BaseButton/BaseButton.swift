//
//  BaseButton.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 02/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

internal class BaseButton: UIButton {
    
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
    
    internal func customize(){
       
    }
    
    internal func setStyle(textColor : UIColor, size fontSize: CGFloat){
        self.setTitleColor(textColor, forState: UIControlState.Normal)
        self.titleLabel?.font = UIFont(name: ProximateSDKSettings.getViewOptions().fontRegular, size: fontSize)
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }

}

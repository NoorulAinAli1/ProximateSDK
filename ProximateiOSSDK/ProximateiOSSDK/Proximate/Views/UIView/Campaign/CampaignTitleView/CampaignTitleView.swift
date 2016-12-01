//
//  CampaignTitleView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignTitleView: UIView {
    @IBOutlet var mainView : UIView!
    
    @IBOutlet var campaignExpiryImage : UIImageView!
    
    @IBOutlet var campaignTitle : UILabel!
    @IBOutlet var campaignExpiryDateTime : UILabel!
    
    override init(frame : CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

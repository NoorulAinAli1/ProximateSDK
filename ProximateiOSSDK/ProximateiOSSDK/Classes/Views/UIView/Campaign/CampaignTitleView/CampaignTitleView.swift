//
//  CampaignTitleView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignTitleView: UIView {
    
    @IBOutlet var campaignExpiryImage : UIImageView!
    
    @IBOutlet var campaignTitle : BaseLabel!
    @IBOutlet var campaignExpiryDateTime : BaseLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCampaign(campaign : ObjectCampaign) {
        self.borderAndShadow()
        
        let expiryStyle = campaign.getCampaignExpiryStyle()
        campaignExpiryDateTime.textColor = expiryStyle.campaignExpiryTextColor
        campaignExpiryImage.image = expiryStyle.campaignExpiryImage
        campaignExpiryDateTime.text = expiryStyle.campaignExpiryText
        
        campaignTitle.setHTMLFromString(campaign.getCampaignTitle(), singleLine: false)
        
    }
}

//
//  CampaignTitleView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignTitleView: CardView {
    
    private var innerPadding : CGFloat  = 0.0
    var campaignExpiryImage : UIImageView?
    private var contentHeight : CGFloat  = 0.0
    
    var campaignTitle : BaseLabel! {
        didSet {
            campaignTitle.numberOfLines = 0
            campaignTitle.isBold = false
            campaignTitle.setStyle(ProximateSDKSettings.getFontStyleOptions().campaignTextFontColor, size: ProximateSDKSettings.getFontStyleOptions().campaignTextFontSize)
        }
    }

    var campaignExpiryDateTime : BaseLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    init(frame : CGRect, withInnerPadding iPadding : CGFloat){
        super.init(frame: frame)
        innerPadding = iPadding
        addViews()
    }

    private func addViews() {
        let viewWidth = self.frame.width/600 * UIScreen.mainScreen().bounds.size.width

        campaignTitle = BaseLabel(frame: CGRectMake(innerPadding, innerPadding, viewWidth - (innerPadding*2), ProximateSDKSettings.getFontStyleOptions().campaignTextFontSize))
        campaignTitle.backgroundColor = UIColor.cyanColor()
        self.addSubview(campaignTitle)
        
        campaignExpiryDateTime = BaseLabel(frame: CGRectMake(innerPadding, ProximateSDKSettings.getFontStyleOptions().campaignTextFontSize + innerPadding + innerPadding, viewWidth - (innerPadding*2), ProximateSDKSettings.getFontStyleOptions().expiryTextFontSize))
        campaignExpiryDateTime.backgroundColor = UIColor.darkGrayColor()
        self.addSubview(campaignExpiryDateTime)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setCampaign(campaign : ObjectCampaign) {
        let viewWidth = self.frame.width/600 * UIScreen.mainScreen().bounds.size.width

        let expiryStyle = campaign.getCampaignExpiryStyle()
        campaignExpiryImage?.image = expiryStyle.campaignExpiryImage
        campaignExpiryDateTime?.text = expiryStyle.campaignExpiryText
        campaignExpiryDateTime?.setStyle(expiryStyle.campaignExpiryTextColor, size: ProximateSDKSettings.getFontStyleOptions().expiryTextFontSize)

//        campaignTitle.text = campaign.getCampaignTitle()
        campaignTitle.setHTMLFromString(campaign.getCampaignTitle(), singleLine: false)
        
        contentHeight = campaignTitle.heightForText( campaign.title, maxWidth: viewWidth - (innerPadding * 4))
        
        var titleFrame = campaignTitle.frame
        titleFrame.size.height = contentHeight
        campaignTitle.frame = titleFrame
        
//        campaignTitle.setHTMLFromString(campaign.getCampaignTitle(), singleLine: false)

        var expFrame = campaignExpiryDateTime.frame
        expFrame.origin.y = contentHeight + innerPadding*2
        campaignExpiryDateTime.frame = expFrame
        
        DebugLogger.debugLog("height \(contentHeight)")
    }
    
    func getContentHeight() -> CGFloat {

        return contentHeight + ProximateSDKSettings.getFontStyleOptions().expiryTextFontSize + innerPadding*5

    }

    override func layoutSubviews(){
        self.campaignTitle.preferredMaxLayoutWidth = self.frame.size.width;
        super.layoutSubviews()
    }
}


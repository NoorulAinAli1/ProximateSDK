//
//  CampaignTitleView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignTitleView: CardView {
    
    private let innerPadding : CGFloat  = ProximateSDKSettings.psdkViewOptions.innerPadding
    var campaignExpiryImage : UIImageView!
    private var contentHeight : CGFloat  = 0.0
    
    var campaignTitle : BaseLabel! {
        didSet {
            campaignTitle.numberOfLines = 0
            campaignTitle.isBold = false
            campaignTitle.setStyle(ProximateSDKSettings.psdkFontOptions.campaignTextFontColor, size: ProximateSDKSettings.psdkFontOptions.campaignTextFontSize)
        }
    }

    var campaignExpiryDateTime : BaseLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame : CGRect){
        super.init(frame: frame)
        addViews()
    }

    private func addViews() {
        let viewWidth = self.frame.width/600 * UIScreen.mainScreen().bounds.size.width

        campaignTitle = BaseLabel(frame: CGRectMake(innerPadding, innerPadding, viewWidth - (innerPadding*2), ProximateSDKSettings.psdkFontOptions.campaignTextFontSize))
        campaignTitle.backgroundColor = UIColor.clearColor()
        self.addSubview(campaignTitle)
        
        
        let expHeight = ProximateSDKSettings.psdkFontOptions.expiryTextFontSize
        campaignExpiryImage = UIImageView(frame: CGRectMake(innerPadding, ProximateSDKSettings.psdkFontOptions.campaignTextFontSize + innerPadding + innerPadding, expHeight * 1.75, expHeight * 1.75))
        campaignExpiryImage.backgroundColor = UIColor.clearColor()
        self.addSubview(campaignExpiryImage)


        campaignExpiryDateTime = BaseLabel(frame: CGRectMake(innerPadding * 2 + expHeight, ProximateSDKSettings.psdkFontOptions.campaignTextFontSize + innerPadding + innerPadding, viewWidth - (innerPadding*3) - expHeight, expHeight))
        campaignExpiryDateTime.backgroundColor = UIColor.clearColor()
        self.addSubview(campaignExpiryDateTime)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setCampaign(campaign : ObjectCampaign) {
        let viewWidth = self.frame.width/600 * UIScreen.mainScreen().bounds.size.width

        let expiryStyle = campaign.getCampaignExpiryStyle()
        campaignExpiryImage.image = expiryStyle.campaignExpiryImage
        campaignExpiryDateTime?.text = expiryStyle.campaignExpiryText
        campaignExpiryDateTime?.setStyle(expiryStyle.campaignExpiryTextColor, size: ProximateSDKSettings.psdkFontOptions.expiryTextFontSize)

//        campaignTitle.text = campaign.getCampaignTitle()
        campaignTitle.setHTMLFromString(campaign.getCampaignTitle(), isSingleLine: false)
        
        contentHeight = campaignTitle.heightForText( campaign.title, maxWidth: viewWidth - (innerPadding * 4))
        
        var titleFrame = campaignTitle.frame
        titleFrame.size.height = contentHeight
        campaignTitle.frame = titleFrame
        
        
        var expImageFrame = campaignExpiryImage.frame
        expImageFrame.origin.y = contentHeight + (innerPadding*1.5)
        campaignExpiryImage.frame = expImageFrame


        var expFrame = campaignExpiryDateTime.frame
        expFrame.origin.y = contentHeight + innerPadding*2
        campaignExpiryDateTime.frame = expFrame
        
        DebugLogger.debugLog("height \(contentHeight)")
    }
    
    func getContentHeight() -> CGFloat {

        return contentHeight + ProximateSDKSettings.psdkFontOptions.expiryTextFontSize + innerPadding*3

    }

    override func layoutSubviews(){
        self.campaignTitle.preferredMaxLayoutWidth = self.frame.size.width;
        super.layoutSubviews()
    }
}


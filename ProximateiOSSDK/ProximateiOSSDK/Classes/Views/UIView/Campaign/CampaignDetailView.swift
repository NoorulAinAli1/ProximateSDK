//
//  CampaignDetailTableViewCell.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 02/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

@objc protocol CampaignActionButtonDelegate {
    func didClickActionButton(campaignActionTag : NSInteger)
}

class CampaignDetailView: CardView {
    private let innerPadding : CGFloat  = ProximateSDKSettings.psdkViewOptions.innerPadding
    private var contentHeight : CGFloat  = 0.0

    var campaignDetailTitle : BaseLabel!
    
    var campaignDetailText : BaseLabel!
    var campaignActionView : UIView!
    var actionDelegate : CampaignActionButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame : CGRect, withDetails detailText : String, withCampaignActions cAction : [ObjectCampaignAction]) {
        super.init(frame: frame)

        let outerPadding : CGFloat  = ProximateSDKSettings.psdkViewOptions.outerPadding

        let viewWidth = self.frame.width/600 * UIScreen.mainScreen().bounds.size.width - (outerPadding * 3)

        campaignDetailTitle = BaseLabel(frame: CGRectMake(innerPadding, innerPadding, viewWidth - (innerPadding*2), ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize))
        campaignDetailTitle.backgroundColor = UIColor.clearColor()
        campaignDetailTitle.text = "psdk_title_details".localized
        campaignDetailTitle.isBold = true
        campaignDetailTitle.setStyle(ProximateSDKSettings.psdkFontOptions.campaignDetailTitleColor, size: ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize)
        self.addSubview(campaignDetailTitle)
        
        campaignDetailText = BaseLabel(frame: CGRectMake(innerPadding, ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize + innerPadding + innerPadding, viewWidth - (innerPadding*2), innerPadding))
        campaignDetailText.numberOfLines = 0
        campaignDetailText.numberOfLines = 0
        campaignDetailText.setStyle(ProximateSDKSettings.psdkFontOptions.campaignDetailTextColor, size: ProximateSDKSettings.psdkFontOptions.campaignDetailTextSize)
        campaignDetailText.backgroundColor = UIColor.clearColor()
        self.addSubview(campaignDetailText)

        campaignDetailText.text = detailText
        
        contentHeight = campaignDetailText.heightForText(detailText, maxWidth: viewWidth - (innerPadding * 4))
        
        var titleFrame = campaignDetailText.frame
        titleFrame.size.height = contentHeight
        titleFrame.size.width = viewWidth - (innerPadding * 2)
        campaignDetailText.frame = titleFrame
        
        DebugLogger.debugLog("height \(contentHeight)")
        
        var startIndex = 0
        let height : CGFloat = ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize * 3
        campaignActionView = UIView(frame: CGRectMake(innerPadding*2, contentHeight + innerPadding + campaignDetailText.frame.origin.y, viewWidth - (innerPadding * 4), CGFloat(cAction.count) * height))
        campaignActionView.backgroundColor = UIColor.clearColor()
        campaignActionView.userInteractionEnabled = true
        self.addSubview( campaignActionView)
        
//        var floatIndex : CGFloat = height * CGFloat(startIndex)
        for campaignAction in cAction {

            contentHeight += height

            var floatIndex = height * CGFloat(startIndex)
            let button = BaseActionButton(frame: CGRect(x:0, y:floatIndex, width: campaignActionView.frame.size.width, height:height - innerPadding))
            button.setTitle(campaignAction.actionTitle, forState: UIControlState.Normal)
            button.tag  = startIndex
            startIndex += 1
            
            button.addTarget(self, action: #selector(CampaignDetailView.campaignActionClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.campaignActionView.addSubview(button)
        }
    }
    
    func campaignActionClicked(sender : BaseActionButton) {
        DebugLogger.debugLog("sender \(sender)")
        actionDelegate?.didClickActionButton(sender.tag)
    }
    
    func getContentHeight() -> CGFloat {
        return contentHeight + ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize + (innerPadding * 3)
    }
    
    override func layoutSubviews(){
//        self.campaignDetailText.preferredMaxLayoutWidth = self.frame.size.width;
        super.layoutSubviews()
    }
}

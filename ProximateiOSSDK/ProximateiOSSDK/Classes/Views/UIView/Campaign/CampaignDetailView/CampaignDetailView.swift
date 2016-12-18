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
    private var innerPadding : CGFloat  = 0.0
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
    
    
    init(frame : CGRect, withInnerPadding iPadding : CGFloat, withDetails detailText : String, withCampaignActions cAction : [ObjectCampaignAction]) {
        super.init(frame: frame)
        innerPadding = iPadding

        let viewWidth = self.frame.width/600 * UIScreen.mainScreen().bounds.size.width

        campaignDetailTitle = BaseLabel(frame: CGRectMake(innerPadding, innerPadding, viewWidth - (innerPadding*2), ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize))
        campaignDetailTitle.backgroundColor = UIColor.cyanColor()
        campaignDetailTitle.text = "psdk_title_details".localized
        campaignDetailTitle.isBold = true
        campaignDetailTitle.setStyle(ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleColor, size: ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize)
        self.addSubview(campaignDetailTitle)
        
        campaignDetailText = BaseLabel(frame: CGRectMake(innerPadding, ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize + innerPadding + innerPadding, viewWidth - (innerPadding*2), innerPadding))
        campaignDetailText.numberOfLines = 0
        campaignDetailText.numberOfLines = 0
        campaignDetailText.setStyle(ProximateSDKSettings.getFontStyleOptions().campaignDetailTextColor, size: ProximateSDKSettings.getFontStyleOptions().campaignDetailTextSize)
        campaignDetailText.backgroundColor = UIColor.darkGrayColor()
        self.addSubview(campaignDetailText)
        
        campaignDetailText.text = detailText
        
        contentHeight = campaignDetailText.heightForText(detailText, maxWidth: viewWidth - (innerPadding * 4))
        
        var titleFrame = campaignDetailText.frame
        titleFrame.size.height = contentHeight
        titleFrame.size.width = viewWidth - (innerPadding * 2)
        campaignDetailText.frame = titleFrame
        
        DebugLogger.debugLog("height \(contentHeight)")
        
        var startIndex = 0
        let height : CGFloat = 40
        campaignActionView = UIView(frame: CGRectMake(innerPadding, contentHeight + innerPadding + campaignDetailText.frame.origin.y, viewWidth - (innerPadding * 2), CGFloat(cAction.count) * height))
        campaignActionView.backgroundColor = UIColor.redColor()
        campaignActionView.userInteractionEnabled = true
        self.addSubview( campaignActionView)
        
        var floatIndex : CGFloat = height * CGFloat(startIndex)
        for campaignAction in cAction {

            contentHeight += height

            floatIndex = height * CGFloat(startIndex)
            let button = BaseActionButton(frame: CGRect(x:30, y:floatIndex, width: viewWidth - 60, height:height - innerPadding))
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
        return contentHeight + ProximateSDKSettings.getFontStyleOptions().campaignDetailTitleSize + (innerPadding * 3)
    }
    
    override func layoutSubviews(){
//        self.campaignDetailText.preferredMaxLayoutWidth = self.frame.size.width;
        super.layoutSubviews()
    }
}

//
//  CampaignDetailTableViewCell.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 02/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

@objc protocol CampaignActionButtonDelegate {
//    optional func didClickActionButton(campaignAction : ObjectCampaignAction)
    func didClickActionButton(campaignActionTag : NSInteger)
}

class CampaignDetailView: UIView {
    
    @IBOutlet var campaignDetailTitle : BaseLabel!
    @IBOutlet var campaignDetailText : BaseLabel!
    
    @IBOutlet weak var campaignActionView : UIView!
    @IBOutlet weak var campaignActionHeight : NSLayoutConstraint!
    var actionDelegate : CampaignActionButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCampaignDetail(detailText : String, campaignActions cAction : [ObjectCampaignAction]) {
        self.borderAndShadow()
        
        campaignDetailText.text = detailText
        
        var startIndex = 0
        let widthForAction = UIScreen.mainScreen().bounds.width - 60//campaignActionView.frame.width * 0.5
        for campaignAction in cAction {
            if campaignAction.actionClass == "REDEEM" { return }
            
            let height : CGFloat = 40

            DebugLogger.debugLog("campaignActionView.frame.width \(campaignActionView.frame.width)" )
            DebugLogger.debugLog("campaignActionVie.width \(UIScreen.mainScreen().bounds)" )

            campaignActionHeight.constant += height
            
            let floatIndex : CGFloat = height * CGFloat(startIndex)
            let button = BaseButton(frame: CGRect(x:30, y:floatIndex, width: widthForAction - 60, height:height - 10))
            button.setTitle(campaignAction.actionTitle, forState: UIControlState.Normal)
            button.tag  = startIndex
            startIndex += 1
            
            button.addTarget(self, action: #selector(CampaignDetailView.campaignActionClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.campaignActionView.addSubview(button)
        }
    }
    
    func campaignActionClicked(sender : BaseButton) {
        DebugLogger.debugLog("sender \(sender)")
        actionDelegate?.didClickActionButton(sender.tag)
    }
}

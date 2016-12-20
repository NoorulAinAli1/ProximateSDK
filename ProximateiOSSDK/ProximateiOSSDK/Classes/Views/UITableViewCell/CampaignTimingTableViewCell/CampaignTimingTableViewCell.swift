//
//  CampaignTimingTableViewCell.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 06/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignTimingTableViewCell: UITableViewCell {
    @IBOutlet var timingImageHeight : NSLayoutConstraint! {
        didSet {
            timingImageHeight.constant = ProximateSDKSettings.psdkFontOptions.campaignDetailTitleSize
        }
    }
    
    @IBOutlet var timingInfoHeight : NSLayoutConstraint!
    
    @IBOutlet var timingImage : UIImageView! {
        didSet {
            timingImage.image = ProximateSDKSettings.getImageForName("icon_timing")
        }
    }
    
    @IBOutlet var timingDay : BaseLabel! {
        didSet {
            timingDay.setStyle(ProximateSDKSettings.psdkFontOptions.campaignDetailTextColor, size: ProximateSDKSettings.psdkFontOptions.campaignDetailTextSize)
        }
    }
    
    @IBOutlet var timingInfo : BaseLabel! {
        didSet {
//            timingInfo.backgroundColor = UIColor.cyanColor()
            timingInfo.setStyle(ProximateSDKSettings.psdkFontOptions.campaignDetailTextColor, size: ProximateSDKSettings.psdkFontOptions.campaignDetailTextSize)
        }
    }
    
    var mTiming : ObjectCampaignTiming! {
        didSet {
            updateView()
        }
    }
    
     private func updateView(){
        timingDay.text = mTiming.getDay()
        timingInfo.text = mTiming.getTiming()
        

    }
    
    func setCurrentDay() {
        timingDay.textColor = ProximateSDKSettings.psdkViewOptions.primaryColor
        timingInfo.textColor = ProximateSDKSettings.psdkViewOptions.primaryColor
        timingImage.image = timingImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        timingImage.tintColor = ProximateSDKSettings.psdkViewOptions.primaryColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

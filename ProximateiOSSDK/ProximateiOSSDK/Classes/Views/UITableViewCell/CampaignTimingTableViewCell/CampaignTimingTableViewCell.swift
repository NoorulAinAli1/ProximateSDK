//
//  CampaignTimingTableViewCell.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 06/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class CampaignTimingTableViewCell: UITableViewCell {
    @IBOutlet var timingImage : UIImageView!
    
    @IBOutlet var timingDay : BaseLabel!
    @IBOutlet var timingInfo : BaseLabel!
    
    var timing : ObjectCampaignTiming! {
        didSet {
            updateView()
        }
    }
    
    private func updateTimingImage() {
        timingImage.image = ProximateSDKSettings.getImageForName("icon_timing")
    }
    
    private func updateView(){
        timingDay.text = timing.getDay()
        timingInfo.text = timing.getTiming()

    }
    
    func setCurrentDay() {
        timingDay.textColor = ProximateSDKSettings.getViewOptions().primaryColor
        timingInfo.textColor = ProximateSDKSettings.getViewOptions().primaryColor
        timingImage.image = timingImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        timingImage.tintColor = ProximateSDKSettings.getViewOptions().primaryColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

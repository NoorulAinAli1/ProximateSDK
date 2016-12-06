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
    
    @IBOutlet var timingDay : UILabel!
    @IBOutlet var timingInfo : UILabel!
    
    var timing : ObjectCampaignTiming! {
        didSet {
            updateView()
        }
    }
    
    private func updateTimingImage() {
        timingImage.image = UIImage(named: "icon_timing.png")
        
    }
    
    private func updateView(){
        timingDay.text = timing.getDay()
        timingInfo.text = timing.getTiming()

    }
    
    func setCurrentDay() {
        timingDay.textColor = UIColor.psdkPrimaryColor()
        timingInfo.textColor = UIColor.psdkPrimaryColor()
        timingImage.image = timingImage.image!.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        timingImage.tintColor = UIColor.psdkPrimaryColor()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

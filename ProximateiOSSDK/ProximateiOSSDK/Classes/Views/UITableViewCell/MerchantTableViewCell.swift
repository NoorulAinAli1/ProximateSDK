//
//  MerchantTableViewCell.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 25/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit
import QuartzCore

@objc protocol MerchantInfoClickDelegate {
    func didClickMerchantShare()
    optional func didClickMerchantLocation()
    optional func didClickMerchantWebsite()
    optional func didClickMerchantPhone()
}

@objc protocol CampaignInfoClickDelegate {
    func didClickCampaignShare(shareText : String )
    func didClickCampaignLocation(campaign : ObjectCampaign)
    optional func didClickCampaignWebsite()
    optional func didClickCampaignPhone()
}

class MerchantTableViewCell: UITableViewCell {
    @IBOutlet var mainView : UIView!

    @IBOutlet var promotionImage : UIImageView!
    @IBOutlet var campaignNewImage : UIImageView!
    @IBOutlet var campaignExpiryImage : UIImageView!
    var delegate : CampaignInfoClickDelegate?

    @IBOutlet var campaignImage : UIImageView!
    @IBOutlet var merchantLogoView : ImageSuperView!

    @IBOutlet var merchantTitle : UILabel!
    @IBOutlet var campaignTitle : UILabel!
    @IBOutlet var campaignExpiryDateTime : UILabel!

    @IBOutlet var btnLocation : ImageCenterButton!
    @IBOutlet var btnShare : ImageCenterButton!
    @IBOutlet var btnMerchantTotalCampaigns : UIButton!
    private var mainCampaign : ObjectCampaign! {
        didSet {
            updateCampaign()
        }
    }
    
    @IBAction func campaignLocationClicked() {
        delegate?.didClickCampaignLocation(mainCampaign)
    }
    
    @IBAction func campaignShareClicked() {
        let shareText = String(format: "psdk__campaign_share".localized, arguments: [self.mainCampaign.title, self.mainCampaign.getMerchant().merchantName, self.mainCampaign.details, ])
        delegate?.didClickCampaignShare(shareText)
    }
    
    
    func setMerchantGroup(merchantGroup : ObjectMerchantGroup){
        mainView.borderAndShadow()
        btnMerchantTotalCampaigns.setTitleColor(UIColor.psdkPrimaryColor(), forState: UIControlState.Normal)
        
        let seeAll = "See All (\(merchantGroup.activeCampaignCount))"
        btnMerchantTotalCampaigns.setTitle(seeAll, forState: .Normal)
        
        merchantTitle.text = merchantGroup.merchantName
        
        mainCampaign = merchantGroup.campaigns![0]
        
        let imgView = UIImageView()
        imgView.af_setImageWithURL(NSURL(string: mainCampaign.getMerchantLogo())!,  completion: { response in
            self.merchantLogoView.image = response.result.value
        })

    }
    
    private func updateCampaign(){
        campaignTitle.setHTMLFromString(mainCampaign.getCampaignTitle())

        campaignImage.af_setImageWithURL(NSURL(string: mainCampaign.getMainMedia().getMediaURL())!, placeholderImage:UIImage(named: "placeholder_campaign.png"))
        let expiryStyle = mainCampaign.getCampaignExpiryStyle()
        campaignExpiryDateTime.textColor = expiryStyle.campaignExpiryTextColor
        campaignExpiryImage.image = expiryStyle.campaignExpiryImage
        campaignExpiryDateTime.text = expiryStyle.campaignExpiryText
        
        btnLocation.hidden = (mainCampaign.beacons == nil)
    }
    
    override func drawRect(rect : CGRect) {
        super.drawRect(rect)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        
    }
}

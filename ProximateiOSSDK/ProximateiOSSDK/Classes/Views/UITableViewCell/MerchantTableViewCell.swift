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
    optional func didClickOnCampaign(campaign : ObjectCampaign)
}

class MerchantTableViewCell: UITableViewCell {
    @IBOutlet var mainView : CardView! {
        didSet {
            self.backgroundColor = UIColor.clearColor()
            self.contentView.backgroundColor = UIColor.clearColor()
        }
    }

    @IBOutlet var promotionImage : UIImageView!
    @IBOutlet var campaignNewImage : UIImageView!
    @IBOutlet var campaignExpiryImage : UIImageView!
    var delegate : CampaignInfoClickDelegate?

    @IBOutlet var campaignImage : UIImageView!
    @IBOutlet var merchantLogoView : ImageSuperView!

    @IBOutlet var merchantTitle : BaseLabel! {
        didSet {
            merchantTitle.setStyle(ProximateSDKSettings.getFontStyleOptions().merchantTitleFontColor, size: ProximateSDKSettings.getFontStyleOptions().merchantTitleFontSize)
        }
    }
    
    @IBOutlet var campaignTitle : BaseLabel! {
        didSet {
            campaignTitle.setStyle(ProximateSDKSettings.getFontStyleOptions().campaignTextFontColor, size: ProximateSDKSettings.getFontStyleOptions().campaignTextFontSize)
        }
    }

    @IBOutlet var campaignExpiryDateTime : BaseLabel!

    @IBOutlet var btnLocation : BaseImageButton!
    @IBOutlet var btnShare : BaseImageButton!
    @IBOutlet var btnMerchantTotalCampaigns : BaseButton!
    private var mainCampaign : ObjectCampaign! {
        didSet {
            updateCampaign()
        }
    }
    
    @IBAction func campaignLocationClicked() {
        delegate?.didClickCampaignLocation(mainCampaign)
    }
    
    @IBAction func campaignShareClicked() {
        let shareText = String(format: "psdk_campaign_share".localized, arguments: [self.mainCampaign.title, self.mainCampaign.getMerchant().merchantName, self.mainCampaign.details])
        delegate?.didClickCampaignShare(shareText)
    }
    
    func setMerchantGroup(merchantGroup : ObjectMerchantGroup){
        let seeAll = String(format: "psdk_button_see_all".localized, arguments: [merchantGroup.activeCampaignCount.integerValue])

        btnMerchantTotalCampaigns.setStyle(ProximateSDKSettings.getFontStyleOptions().seeAllFontColor, size: ProximateSDKSettings.getFontStyleOptions().seeAllFontSize)

        btnMerchantTotalCampaigns.setTitle(seeAll, forState: .Normal)
        
        merchantTitle.text = merchantGroup.merchantName
        
        mainCampaign = merchantGroup.campaigns![0]
        
        let imgView = UIImageView()
        imgView.af_setImageWithURL(NSURL(string: mainCampaign.getMerchantLogo())!,  completion: { response in
            self.merchantLogoView.image = response.result.value
        })

    }
    
    private func updateCampaign(){
//        merchantTitle.style(Styles.Labels.Standard(20), color: UIColor.purpleColor())

        campaignTitle.setHTMLFromString(mainCampaign.getCampaignTitle())

        campaignImage.af_setImageWithURL(NSURL(string: mainCampaign.getMainMedia().getMediaURL())!, placeholderImage: ProximateSDKSettings.getCampaignPlaceholderImage())
        let expiryStyle = mainCampaign.getCampaignExpiryStyle()
//        campaignExpiryDateTime.textColor = expiryStyle.campaignExpiryTextColor
        campaignExpiryImage.image = expiryStyle.campaignExpiryImage
        campaignExpiryDateTime.text = expiryStyle.campaignExpiryText
        campaignExpiryDateTime.setStyle(expiryStyle.campaignExpiryTextColor, size: ProximateSDKSettings.getFontStyleOptions().expiryTextFontSize)

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

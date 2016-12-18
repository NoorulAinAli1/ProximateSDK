//
//  MerchantHeaderView.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 27/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class MerchantHeaderView: UIView {
    
    @IBOutlet var merchantBanner : UIImageView!
    @IBOutlet var merchantLogo : ImageSuperView!
    var delegate : MerchantInfoClickDelegate?
    
    @IBOutlet var merchantTitle : BaseLabel! {
        didSet {
            merchantTitle.setStyle(ProximateSDKSettings.getFontStyleOptions().merchantTitleFontColor, size: ProximateSDKSettings.getFontStyleOptions().merchantTitleFontSize)

        }
    }
    @IBOutlet var merchantSlogan : BaseLabel!{
        didSet {
            merchantSlogan.setStyle(ProximateSDKSettings.getFontStyleOptions().merchantTaglineFontColor, size: ProximateSDKSettings.getFontStyleOptions().merchantTaglineFontSize)
        }
    }

    @IBOutlet var btnWebsiteWidth : NSLayoutConstraint!

    @IBOutlet var btnLocation : BaseImageButton!
    @IBOutlet var btnShare : BaseImageButton!
    @IBOutlet var btnWebsite : BaseImageButton!
    @IBOutlet var btnPhone : BaseImageButton!
    private let colorCube = CCColorCube()

    private var merchantBannerColor : UIColor! = ProximateSDKSettings.getViewOptions().primaryColor
    
    private var mMerchant : ObjectMerchant!
    
    func setMerchant(merchant : ObjectMerchant){
        mMerchant = merchant
        merchantTitle.text = mMerchant.merchantName
        merchantSlogan.text = mMerchant.tagLine


        merchantBanner.af_setImageWithURL(NSURL(string: mMerchant.getBanner())!,  completion: { response in
            
            if response.result.error == nil {
                let bannerImage = response.result.value

                let colors = self.colorCube.extractColorsFromImage(bannerImage!, flags: CCAvoidWhite.rawValue) as! [UIColor]

                self.merchantBannerColor = colors[0]
                self.merchantBanner.image = bannerImage
            }
        })

        let img : UIImageView = UIImageView()
        img.af_setImageWithURL(NSURL(string: mMerchant.merchantLogoPath)!,  completion: { response in
            self.merchantLogo.image = response.result.value
        })
        
        btnPhone.hidden = !merchant.hasPhoneNumber()
        btnWebsite.hidden = !merchant.hasWebsite()
        btnWebsiteWidth.constant = merchant.hasWebsite() ? self.btnWebsite.frame.width : 0

    }
    
    @IBAction func merchantLocationClicked() {
        delegate?.didClickMerchantLocation!()
    }
    
    @IBAction func merchantPhoneClicked() {
        delegate?.didClickMerchantPhone!()
    }
    
    @IBAction func merchantShareClicked() {
        delegate?.didClickMerchantShare()
    }
    
    @IBAction func merchantWebsiteClicked() {
        delegate?.didClickMerchantWebsite!()
    }
    
    func getAverageColor () -> UIColor? {
        return self.merchantBannerColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

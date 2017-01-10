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
            merchantTitle.setStyle(ProximateSDKSettings.psdkFontOptions.merchantTitleFontColor, size: ProximateSDKSettings.psdkFontOptions.merchantTitleFontSize)

        }
    }
    @IBOutlet var merchantSlogan : BaseLabel!{
        didSet {
            merchantSlogan.setStyle(ProximateSDKSettings.psdkFontOptions.merchantTaglineFontColor, size: ProximateSDKSettings.psdkFontOptions.merchantTaglineFontSize)
        }
    }

    @IBOutlet var btnWebsiteWidth : NSLayoutConstraint!

    @IBOutlet var btnLocation : UIButton!
    @IBOutlet var btnShare : UIButton!
    @IBOutlet var btnWebsite : UIButton!
    @IBOutlet var btnPhone : UIButton!
    private let colorCube = CCColorCube()

    private var merchantBannerColor : UIColor! = ProximateSDKSettings.psdkViewOptions.primaryColor
    
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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnPhone.hidden = !mMerchant.hasPhoneNumber()
        btnWebsite.hidden = !mMerchant.hasWebsite()
        btnWebsiteWidth.constant = mMerchant.hasWebsite() ? self.btnShare.frame.width : 0
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

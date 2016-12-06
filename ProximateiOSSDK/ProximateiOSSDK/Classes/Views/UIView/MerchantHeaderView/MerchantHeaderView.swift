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
    
    @IBOutlet var merchantTitle : UILabel!
    @IBOutlet var merchantSlogan : UILabel!
    
    @IBOutlet var btnLocation : ImageCenterButton!
    @IBOutlet var btnShare : ImageCenterButton!
    @IBOutlet var btnWebsite : ImageCenterButton!
    @IBOutlet var btnPhone : ImageCenterButton!
    private let colorCube = CCColorCube()

    private var merchantBannerColor : UIColor! = UIColor.psdkPrimaryColor()
    
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
        
        btnPhone.hidden = merchant.hasPhoneNumber()
        btnWebsite.hidden = merchant.hasWebsite()
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

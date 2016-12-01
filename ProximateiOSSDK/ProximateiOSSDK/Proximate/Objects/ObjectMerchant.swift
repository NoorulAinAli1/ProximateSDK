//
//  ObjectMerchant.swift
//  ProximateiOSSDK
// 
//  Created by Noor ul Ain Ali on 03/06/2015.
//  Copyright (c) 2015 Avanza Solutions. All rights reserved.
//

import UIKit


class ObjectMerchant: NSObject {
    var merchantId      : NSNumber!
    var merchantName    : String!
    var merchantLogoPath    : String!
    var merchantBanner   : String?
    var tagLine   : String?
    var phone   : String?
    var website : String?
    var email   : String?

    override init(){
        super.init()
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectMerchant else {
            return false
        }
        let lhs = self
        
        return lhs.merchantId == rhs.merchantId
    }
    
    func getMerchantId() -> NSInteger {
        return merchantId.integerValue
    }
    
    func getPhoneNumber() -> String {
        return self.phone!.stringByReplacingOccurrencesOfString(" ", withString: "")
    }
    
    func hasWebsite() -> Bool {
       return website?.utf16.count != 0
    }
    
    func hasPhoneNumber() -> Bool {
        return phone?.utf16.count != 0
    }
    
    func getBanner() -> String {
        
//        var bannerImage = merchantBanner ?? merchantLogoPath
        let bannerImage = merchantBanner!.containsString("/null") ? merchantLogoPath : merchantBanner!
        return bannerImage!
    }
    
    func getMerchantWebsite() -> String {
        var mWebsite : String = self.website!
        if !mWebsite.hasPrefix("http"){
            mWebsite = "https://\(website)"
        }
        return mWebsite
    }
}

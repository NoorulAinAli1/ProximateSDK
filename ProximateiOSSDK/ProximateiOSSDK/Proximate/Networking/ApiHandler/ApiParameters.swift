//
//  ApiParameters.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 14/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit

class ApiParameters: NSObject {
    
    enum ACTIVITY_TYPE : Int {
        case kShareCampaign = 8,
            kShareMerchant = 18
    
    }
    
    private static func getWiFiAddress() -> String {
        var address : String = "194.252.142.15"
        
//        // Get list of all interfaces on the local machine:
//        var ifaddr : UnsafeMutablePointer<ifaddrs> = nil
//        if getifaddrs(&ifaddr) == 0 {
//            
//            // For each interface ...
//            var ptr = ifaddr
//            while ptr != nil {
//                defer { ptr = ptr.memory.ifa_next }
//                
//                let interface = ptr.memory
//                
//                // Check for IPv4 or IPv6 interface:
//                let addrFamily = interface.ifa_addr.memory.sa_family
//                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
//                    
//                    // Check interface name:
//                    if let name = String.fromCString(interface.ifa_name) where name == "en0" {
//                        
//                        // Convert interface address to a human readable string:
//                        var addr = interface.ifa_addr.memory
//                        var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
//                        getnameinfo(&addr, socklen_t(interface.ifa_addr.memory.sa_len),
//                                    &hostname, socklen_t(hostname.count),
//                                    nil, socklen_t(0), NI_NUMERICHOST)
//                        address = String.fromCString(hostname)
//                    }
//                }
//            }
//            freeifaddrs(ifaddr)
//        }
        
        return address
    }
    
    static func getVerifyMerchantParams(apiKey : String) -> [String : AnyObject]{
    
        return [JSON_Keys.APP_PACKAGE_IDENTIFIER : ProximateiOSSDK.getPackageIdentifer(),
                JSON_Keys.API_KEY : apiKey,
                JSON_Keys.DEVICE_TYPE     : JSON_Keys.DEVICE_IPHONE]
    }
    
    static func getAllSearchParams(search : String = "", forPageNumber pageNumber : NSInteger) -> [String : AnyObject]{
        let pager = [JSON_Keys.PAGE_NUMBER : pageNumber,
                     "size"   : 4]// JSON_Keys.PAGE_SIZE]
       return [JSON_Keys.APP_PACKAGE_IDENTIFIER : ProximateiOSSDK.getPackageIdentifer(),
            JSON_Keys.MERCHANT_IDES : [],
         JSON_Keys.CATEGORY_IDES     : [],
         JSON_Keys.IMP_LOCATION_IDES  : [],
         JSON_Keys.TEXT             : search,
         JSON_Keys.PAGER            : pager]
    }
    
    static func getParticularCategoryParams(search : String = "", forCategoryId categoryId : NSInteger, forPageNumber pageNumber : NSInteger = 0) -> [String : AnyObject]{
        let pager = [JSON_Keys.PAGE_NUMBER : pageNumber,
                     "size"   : 4]//JSON_Keys.PAGE_SIZE]
        return [JSON_Keys.APP_PACKAGE_IDENTIFIER : ProximateiOSSDK.getPackageIdentifer(),
                JSON_Keys.MERCHANT_IDES : [],
                JSON_Keys.CATEGORY_IDES     : [categoryId],
                JSON_Keys.IMP_LOCATION_IDES  : [],
                JSON_Keys.TEXT             : search,
                JSON_Keys.PAGER            : pager]
    }
    
    static func getParticularMerchantParams(merchantId : NSInteger, forPageNumber pageNumber : NSInteger) -> [String : AnyObject]{
        let pager = [JSON_Keys.PAGE_NUMBER : pageNumber,
                     "size"   : 4]//JSON_Keys.PAGE_SIZE]
        return [JSON_Keys.APP_PACKAGE_IDENTIFIER : ProximateiOSSDK.getPackageIdentifer(),
                JSON_Keys.MERCHANT_IDES     : [merchantId],
                JSON_Keys.CATEGORY_IDES     : [],
                JSON_Keys.IMP_LOCATION_IDES : [],
                JSON_Keys.TEXT              : "",
                JSON_Keys.PAGER             : pager]
    }

    static func getMerchantParams(mId : NSNumber) -> [String : AnyObject] {
        return [JSON_Keys.APP_PACKAGE_IDENTIFIER : ProximateiOSSDK.getPackageIdentifer(),
                JSON_Keys.MERCHANT_ID       : mId]
    }

    static func getNearbyCampaignsParams(latitude : CGFloat, andLongitude longitude : CGFloat, andDistance distance : NSInteger) -> [String : AnyObject] {
        return [JSON_Keys.APP_PACKAGE_IDENTIFIER : ProximateiOSSDK.getPackageIdentifer(),
                "lat"       : latitude,
                "lng"       : longitude,
                "distance"  : distance
            ]
    }
    
    static func getCampaignForIdParam(cid: NSNumber, isAd ad : NSNumber = 1) -> [String : AnyObject] {
        return [JSON_Keys.APP_PACKAGE_IDENTIFIER : ProximateiOSSDK.getPackageIdentifer(),
                JSON_Keys.CAMPAIGN_IS_AD    : ad,
                JSON_Keys.CAMPAIGN_ID       : cid]
    }
  
    static func updateCampaignShareActivity(forCampaignId cid: NSNumber, forAppName appName : String = "") -> [String : AnyObject] {
        return [JSON_Keys.APP_PACKAGE_IDENTIFIER : ProximateiOSSDK.getPackageIdentifer(),
                JSON_Keys.ACTIVITY_TYPE   : ACTIVITY_TYPE.kShareCampaign.rawValue,
                JSON_Keys.IP_ADDRESS  : getWiFiAddress(),
                JSON_Keys.SHARED_TO  : appName.uppercaseString,
                JSON_Keys.DEVICE_NAME : UIDevice.currentDevice().model,
                JSON_Keys.CAMPAIGN_IDS: [cid],
                JSON_Keys.COMMENT_TEXT :""
        ]
    }
    
    static func updateMerchantShareActivity(forMerchantId mid: NSNumber, forAppName appName : String = "") -> [String : AnyObject] {
        return [JSON_Keys.APP_PACKAGE_IDENTIFIER : ProximateiOSSDK.getPackageIdentifer(),
                JSON_Keys.ACTIVITY_TYPE   : ACTIVITY_TYPE.kShareMerchant.rawValue,
                JSON_Keys.IP_ADDRESS  : getWiFiAddress(),
                JSON_Keys.SHARED_TO  : appName.uppercaseString,
                JSON_Keys.DEVICE_NAME : UIDevice.currentDevice().model,
                JSON_Keys.SHARED_MERCHANT_ID: mid,
                JSON_Keys.COMMENT_TEXT :""
        ]
    }
}

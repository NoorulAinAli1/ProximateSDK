//
//  JSON_Keys.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 01/06/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit

class JSON_Keys: NSObject {
    static let APP_PACKAGE_IDENTIFIER = "packageName"
    static let API_KEY          = "apiKey";
    
    static let CODE             = "code"
    static let GRANT_TYPE       = "grant_type"
    static let CLIENT_ID        = "client_id"
    static let CLIENT_SECRET    = "client_secret"
    static let PUSH_NOTIFICATION_ID     = "pushNotificationId"
    static let DEVICE_TYPE      = "deviceType"
    static let DEVICE_NAME      = "deviceName"
    static let ATTRIBUTES       = "attributes"
    static let RESTAPP          = "restapp"
    static let DEVICE_IPHONE    = "iPhone".uppercaseString
    static let IP_ADDRESS       = "ipAddress"
    static let COMMENT_TEXT     = "commentText"
    static let ACTIVITY_TYPE    = "activityType"
    static let SHARED_TO        = "sharedTo"
  
    static let BODY             = "body"
    static let STATUS           = "status"
    
    // page related keys
    static let PAGE_NUMBER      = "pageNo"
    static let PAGER            = "pager"
    static let SORT_ORDER       = "sortOrder"
    static let SIZE             = "size"
    
    // search keys
    static let TEXT             = "text"
    static let MERCHANT_IDES    = "merchantIdes"
    static let MERCHANT_ID      = "merchantId"
    static let CATEGORY_IDES    = "categoryIdes"
    static let IMP_LOCATION_IDES    = "impLocationIdes"
    
    // merchant related keys
    static let SHARED_MERCHANT_ID   = "sharedMerchantId"
    
    // campaign related keys
    static let CAMPAIGN_ID      = "campaignId"
    static let CAMPAIGN_IDS     = "campaignIdes"
    
    static let STORES           = "stores"//
    static let CAMPAIGN_IS_AD               = "isAdd"
    
}

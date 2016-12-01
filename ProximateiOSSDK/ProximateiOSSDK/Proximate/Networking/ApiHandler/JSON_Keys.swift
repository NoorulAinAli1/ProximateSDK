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
//    static let PAGE_SIZE       : NSNumber = 4
    
    // search keys
    static let TEXT             = "text"
    static let MERCHANT_IDES    = "merchantIdes"
    static let CATEGORY_IDES    = "categoryIdes"
    static let IMP_LOCATION_IDES    = "impLocationIdes"
    
    // merchant related keys
    static let MERCHANT         = "merchant"
    static let SHARED_MERCHANT_ID   = "sharedMerchantId"
    static let MERCHANT_ID      = "merchantId"
    static let MERCHANT_NAME    = "merchantName"
    static let MERCHANT_BANNER  = "merchantBanner"
    static let MERCHANT_LOGO    = "merchantLogoPath"
    static let MERCHANT_TAG_LINE    = "tagLine"
    static let MERCHANT_PHONE   = "phone"
    static let MERCHANT_WEBSITE = "website"
    static let MERCHANT_EMAIL   = "email"
    static let MERCHANT_ACTIVE_CAMPAIGN_COUNT   = "activeCampaignCount"
    
    // campaign related keys
    static let CAMPAIGN_ID      = "campaignId"
    static let CAMPAIGN_IDS     = "campaignIdes"
    static let CAMPAIGN_TITLE   = "title"
    static let CAMPAIGN_FORMATTED_TITLE     = "formattedTitle"
    static let CAMPAIGN_DETAILS = "details"
    static let CAMPAIGN_LAYOUT  = "campaignLayout"
    static let CAMPAIGN_SUMMARY = "summary"
    static let CAMPAIGN_SNOOZE_TIME         = "snoozeTimeInMinutes"
    static let CAMPAIGN_COUNT_COMMENTS      = "commentsCounts"
    static let CAMPAIGN_COUNT_LIKES         = "likesCount"
    static let CAMPAIGN_COUNT_SHARE         = "shareCount"
    static let CAMPAIGN_COUNT_SEEN          = "seenCount"
    static let CAMPAIGN_IS_AD               = "isAdd"
    static let CAMPAIGN_IS_FAV              = "isFav"
    static let CAMPAIGN_IS_COMMENTED        = "isCommented"
    static let CAMPAIGN_IS_LIKED            = "isLiked"
    static let CAMPAIGN_DATE_TIME_START     = "startDateTime"
    static let CAMPAIGN_DATE_TIME_END       = "expiryDateTime"
    
//    modelCampaign.isFav = (campaign.objectForKey("favorite") as? NSNumber)!
//    modelCampaign.isLiked = (campaign.objectForKey("liked") as? NSNumber)!

    // campaign action related keys
    static let CAMPAIGN_ACTION          = "campaignActions"
    static let CAMPAIGN_ACTION_CLASS    = "actionClass"
    static let CAMPAIGN_ACTION_TITLE    = "actionTitle"
    static let CAMPAIGN_ACTION_TYPE     = "actionType"
    static let CAMPAIGN_ACTION_FIELD_1  = "field1"
    static let CAMPAIGN_ACTION_FIELD_2  = "field2"
    static let CAMPAIGN_ACTION_URL      = "url"
    static let CAMPAIGN_EXTERNAL_BROWSER    = "externalBrowser"
    
    // campaign media related keys
    static let TYPE                     = "type"
    static let PATH                     = "path"
    static let TITLE                    = "title"
    static let TARGET_DEVICE            = "targetDevice"
    
    // campaign timing related keys
    static let CAMPAING_TIMINGS         = "campaignTimings"
    static let CAMPAING_TIMING_ID       = "campaignTimingId"
    static let CAMPAING_TIMING_DAY      = "day"
    static let CAMPAING_TIMING_START_TIME       = "startTime"
    static let CAMPAING_TIMING_START_TIME2      = "startTime2"
    static let CAMPAING_TIMING_END_TIME         = "endTime"
    static let CAMPAING_TIMING_END_TIME2        = "endTime2"

    // category 
    static let CATEGORY_ID      = "prodCategoryId"
    static let CATEGORY_TITLE   = "title"
    
    // store location country city related keys
    static let COUNTRY_CODE     = "countryCode"
    static let COUNTRY_ID       = "countryId"
    static let COUNTRY_NAME     = "countryName"
    static let CITY             = "city"
    static let CITY_ID          = "cityId"
    static let CITY_NAME        = "cityName"
    static let GEO_LOCATION     = "geoLocation"
    static let STORE_ID         = "storeId"
    static let STORES           = "stores"
    static let STORE_TITLE      = "storeTitle"
    static let STORE_NAME       = "storeName"
    static let IMP_LOCATION_ID  = "impLocationId"
    static let IMP_LOCATION_NAME        = "impLocationName"
    static let MALL_ID          = "mallId"
    
    static let LATITUDE         = "lat"
    static let LONGITUDE        = "lng"
    static let DISTANCE         = "distance"

    
    
}

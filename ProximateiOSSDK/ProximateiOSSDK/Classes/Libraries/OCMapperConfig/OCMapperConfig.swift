//
//  OCMapperConfig.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 06/12/2016.
//
//

import Foundation
import OCMapper

class OCMapperConfig: NSObject {
    
    static func configure() {
        
        let inCodeMappingProvider = InCodeMappingProvider()
        let commonLoggingProvider = CommonLoggingProvider(logLevel: LogLevelError)
        
        ObjectMapper.sharedInstance().mappingProvider = inCodeMappingProvider
        ObjectMapper.sharedInstance().loggingProvider = commonLoggingProvider
        
        /******************* Any custom mapping would go here **********************/
        inCodeMappingProvider.mapFromDictionaryKey("campaigns",
                                                   toPropertyKey: "campaigns",
                                                   withObjectType: ObjectCampaign.classForCoder(),
                                                   forClass: ObjectMerchantGroup.self)
        
        inCodeMappingProvider.mapFromDictionaryKey("merchant",
                                                   toPropertyKey: "merchant",
                                                   withObjectType: ObjectMerchant.classForCoder(),
                                                   forClass: ObjectCampaign.self)
        
        inCodeMappingProvider.mapFromDictionaryKey("beacons",
                                                   toPropertyKey: "beacons",
                                                   withObjectType: ObjectBeacon.classForCoder(),
                                                   forClass: ObjectCampaign.self)
    
        inCodeMappingProvider.mapFromDictionaryKey("campaignActions",
                                                   toPropertyKey: "campaignActions",
                                                   withObjectType: ObjectCampaignAction.classForCoder(),
                                                   forClass: ObjectCampaign.self)
      
        inCodeMappingProvider.mapFromDictionaryKey("contents",
                                                   toPropertyKey: "contents",
                                                   withObjectType: ObjectCampaignMedia.classForCoder(),
                                                   forClass: ObjectCampaign.self)
       
        inCodeMappingProvider.mapFromDictionaryKey("media",
                                                   toPropertyKey: "media",
                                                   withObjectType: ObjectCampaignMedia.classForCoder(),
                                                   forClass: ObjectCampaignAction.self)
      
        inCodeMappingProvider.mapFromDictionaryKey("geoLocation",
                                                   toPropertyKey: "geoLocation",
                                                   withObjectType: ObjectGeoLocation.classForCoder(),
                                                   forClass: ObjectBeacon.self)
       
        inCodeMappingProvider.mapFromDictionaryKey("geoLocation",
                                                   toPropertyKey: "geoLocation",
                                                   withObjectType: ObjectGeoLocation.classForCoder(),
                                                   forClass: ObjectStore.self)
       
        inCodeMappingProvider.mapFromDictionaryKey("geoLocation",
                                                   toPropertyKey: "geoLocation",
                                                   withObjectType: ObjectGeoLocation.classForCoder(),
                                                   forClass: ObjectStore.self)
    
        inCodeMappingProvider.mapFromDictionaryKey("storeDTO",
                                                   toPropertyKey: "storeDTO",
                                                   withObjectType: ObjectStore.classForCoder(),
                                                   forClass: ObjectBeacon.self)
    
        inCodeMappingProvider.mapFromDictionaryKey("y",
                                                   toPropertyKey: "latitude",
                                                   forClass: ObjectGeoLocation.self)
        
        inCodeMappingProvider.mapFromDictionaryKey("x",
                                                   toPropertyKey: "longitude",
                                                   forClass: ObjectGeoLocation.self)
        
        inCodeMappingProvider.mapFromDictionaryKey("merchantBannerPath",
                                                   toPropertyKey: "merchantBanner",
                                                   forClass: ObjectMerchant.self)
        
        inCodeMappingProvider.mapFromDictionaryKey("campaignTimings",
                                                   toPropertyKey: "campaignTimings",
                                                   withObjectType: ObjectCampaignTiming.classForCoder(),
                                                   forClass: ObjectCampaign.self)
        
        inCodeMappingProvider.mapFromDictionaryKey("cards",
                                                   toPropertyKey: "cards",
                                                   withObjectType: ObjectBankCard.classForCoder(),
                                                   forClass: ObjectBank.self)
        
        inCodeMappingProvider.mapFromDictionaryKey("campaignCards",
                                                   toPropertyKey: "campaignCards",
                                                   withObjectType: ObjectBank.classForCoder(),
                                                   forClass: ObjectCampaign.self)
    }
}

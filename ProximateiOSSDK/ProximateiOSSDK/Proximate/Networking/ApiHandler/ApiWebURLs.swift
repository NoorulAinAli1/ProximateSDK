//
//  ApiWebURLs.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 14/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit

class ApiWebURLs: NSObject {
    static let baseURLService   = "http://125.209.114.194:8082/ProximateService/restsimple/"
//    static let baseURLService   = "http://services.proximate.ae:8082/ProximateService/restsimple/"
    static let baseURLRestCampaign  = "\(baseURLService)campaign/"
    static let baseURLRestCategory  = "\(baseURLService)category/"
    static let baseURLRestMerchant  = "\(baseURLService)merchant/"
    static let baseURLRestStore     = "\(baseURLService)store/"
    
    static func fetchMerchantStores(tag : String)-> String {
        return "\(baseURLRestStore)list?\(tag)".urlEncoding()
    }
    
    static func verifyMerchantApiKey()-> String {
        return "\(baseURLService)verification/verifyMerchantAPIKey"
    }
    
    static func getCampaignByCampaignId(tag : String) -> String {
        return "\(baseURLRestCampaign)getCampaignByCampaignId?\(tag))".urlEncoding()
    }
    
    static func sendFeedbackForCampaign() -> String {
        return "\(baseURLRestCampaign)updateCampaignActivity"
    }
    
    static func sendFeedbackForMerchant() -> String {
        return "\(baseURLRestMerchant)updateMerchantActivity"
    }
    
    static func getSearchCampaignUrl(tag : String) -> String {
        return "\(baseURLRestCampaign)searchCampaign?\(tag)".urlEncoding()
    }
    
    static func getGroupedCampaignsUrl(tag : String) -> String {
        return "\(baseURLRestCampaign)searchCampaignGroupped?\(tag)".urlEncoding()
    }
    
    static func getAllCategories() -> String {
        return "\(baseURLRestCategory)getParentCategoriesCloud"
    }
    
    static func getAppVersion() -> String {
        return "http://itunes.apple.com/pk/lookup?bundleId=com.proximate.customer.retailapp"
    }
    
}

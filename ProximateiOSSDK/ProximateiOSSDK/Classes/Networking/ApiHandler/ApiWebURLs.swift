//
//  ApiWebURLs.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 14/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit

class ApiWebURLs: NSObject {
    
    private static let baseURLRestCampaign  = "\(DebugLogger.getServerUrl())campaign/"
    private static let baseURLRestCategory  = "\(DebugLogger.getServerUrl())category/"
    private static let baseURLRestMerchant  = "\(DebugLogger.getServerUrl())merchant/"
    private static let baseURLRestStore     = "\(DebugLogger.getServerUrl())store/"
    
    static func fetchMerchantStores(tag : String) -> String {
        return "\(baseURLRestStore)list?\(tag)".urlEncoding()
    }
    
    static func verifyMerchantApiKey(tag : String) -> String {
        return "\(DebugLogger.getServerUrl())verification/verifyMerchantAPIKey?\(tag))".urlEncoding()
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

//
//  ApiHandler.swift
//  ProximateSDK
//
//  Created by NoorulAinAli on 14/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit
import OCMapper

class ApiHandler: NSObject {
    
    static let sharedInstance = ApiHandler()

    private func showMessageFromData(data : NSData) {
        var msg = ""
        do {
            let JSON = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            msg =  JSON["message"] as! String
            ProximateSDK.getMessageDelegate()?.showMessage(msg)
            
        } catch _ as NSError {
            msg = "psdk_error_something_went_wrong".localized
            ProximateSDK.getMessageDelegate()?.showMessage(msg, forMessageType: .Error)
        }
        
    }
    
    func verifyMerchant(apiKey : String, completion:(result : Bool) -> Void){
        Alamofire.sharedInstance.startRequest(method: .POST, URLString: ApiWebURLs.verifyMerchantApiKey("\(apiKey)_\(ProximateSDK.getPackageIdentifer())"), parameters:ApiParameters.getVerifyMerchantParams(apiKey), encoding: .JSON, success: {
            JSON in
            
            var res = false
            
            DebugLogger.debugLog("JSON: \(JSON)")
            let merchantId = JSON![JSON_Keys.MERCHANT_ID] as! NSNumber

            DebugLogger.debugLog("merchantId: \(merchantId)")

            if merchantId.integerValue != 0 {                
                guard let object = ObjectMapper.sharedInstance().objectFromSource(JSON, toInstanceOfClass: PSDKMerchant.self) as? PSDKMerchant else {
                    completion(result: res)
                    return
                }
                DebugLogger.debugLog("object \(object)")
                res = true
            }
            
            completion(result: res)
            }, failure: {failureError in
                completion(result : false)
                self.showMessageFromData(failureError.1 as! NSData)
        })
    }
 
    func getAllCategories(completion:(categories : [ObjectCategory]) -> Void){
        var allCategories : [ObjectCategory] = []
        Alamofire.sharedInstance.startRequest(method: .GET, URLString: ApiWebURLs.getAllCategories(), parameters:nil, encoding: .JSON, success: {JSON in
            
//            DebugLogger.debugLog("JSON: \(JSON)")

            if JSON![JSON_Keys.BODY] != nil {
                let jsonDict = JSON![JSON_Keys.BODY] as! [NSDictionary]
                
                guard let object = ObjectMapper.sharedInstance().objectFromSource(jsonDict, toInstanceOfClass: ObjectCategory.self) as? [ObjectCategory] else {
                    completion(categories: allCategories)
                    return
                }
                allCategories = object
            }
            completion(categories: allCategories)
            
            }, failure: {failureError in
                self.showMessageFromData(failureError.1 as! NSData)
                completion(categories: allCategories)
        })
    }
    
    func getCampaignsForMerchant(merchantId : NSInteger, andPageNumber pageNumber : NSInteger, completion:(campaigns : [ObjectCampaign]) -> Void){
        var allCampaigns : [ObjectCampaign] = []
        Alamofire.sharedInstance.startRequest(method: .POST, URLString: ApiWebURLs.getSearchCampaignUrl("\(merchantId)_\(pageNumber)"), parameters:ApiParameters.getParticularMerchantParams(merchantId, forPageNumber: pageNumber), encoding: .JSON, success: {JSON in
            
//            DebugLogger.debugLog("JSON: \(JSON)")
            
            if JSON![JSON_Keys.BODY] != nil {
                let jsonDict = JSON![JSON_Keys.BODY] as! [NSDictionary]
                
                guard let object = ObjectMapper.sharedInstance().objectFromSource(jsonDict, toInstanceOfClass: ObjectCampaign.self) as? [ObjectCampaign] else {
                    completion(campaigns: allCampaigns)
                    return
                }
                allCampaigns = object
//                let cArray = JSON![JSON_Keys.BODY] as! NSArray
//                DebugLogger.debugLog("cArray: \(cArray.count)")
//                for dict in cArray {
//                    let d = dict as! NSDictionary
//                    let cat = ObjectCampaign(dictionary: d)
//                    allCampaigns.append(cat)
//                }
            }
            completion(campaigns: allCampaigns)
            
            }, failure: {failureError in
                self.showMessageFromData(failureError.1 as! NSData)
                completion(campaigns: allCampaigns)
        })
    }
    
    func getCampaignsForCategory(search : String = "", andCategoryId categoryId : NSInteger, andPageNumber pageNumber : NSInteger, completion:(merchantCampaigns : [ObjectMerchantGroup]) -> Void){
        var allCampaigns : [ObjectMerchantGroup] = []
        Alamofire.sharedInstance.startRequest(method: .POST, URLString: ApiWebURLs.getGroupedCampaignsUrl("\(categoryId)_\(search)_\(pageNumber)"), parameters:ApiParameters.getParticularCategoryParams(search, forCategoryId: categoryId, forPageNumber: pageNumber), encoding: .JSON, success: {JSON in
            
//            DebugLogger.debugLog("JSON: \(JSON)")
            
            if JSON![JSON_Keys.BODY] != nil {
                let jsonDict = JSON![JSON_Keys.BODY] as! [NSDictionary]
                
                guard let object = ObjectMapper.sharedInstance().objectFromSource(jsonDict, toInstanceOfClass: ObjectMerchantGroup.self) as? [ObjectMerchantGroup] else {
                    completion(merchantCampaigns: allCampaigns)
                    return
                }
                allCampaigns = object
            }
            completion(merchantCampaigns: allCampaigns)
            
            }, failure: {failureError in
                self.showMessageFromData(failureError.1 as! NSData)
                completion(merchantCampaigns: allCampaigns)
        })
    }
    
    func getAllCampaigns(search : String = "", andPageNumber pageNumber : NSInteger, completion:(merchantCampaigns : [ObjectMerchantGroup]) -> Void){
        var allCampaigns : [ObjectMerchantGroup] = []
        Alamofire.sharedInstance.startRequest(method: .POST, URLString: ApiWebURLs.getGroupedCampaignsUrl("All_\(search)_\(pageNumber)"), parameters:ApiParameters.getAllSearchParams(search, forPageNumber: pageNumber), encoding: .JSON, success: {JSON in
            
//            DebugLogger.debugLog("JSON: \(JSON)")
            
            if JSON![JSON_Keys.BODY] != nil {
                let jsonDict = JSON![JSON_Keys.BODY] as! [NSDictionary]
                
                if (search.utf8.count > 0 && jsonDict.count == 0){
                    let toastMessage = String(format: "psdk_message_no_campaign_found_in_search".localized, arguments: [search])
                    ProximateSDK.getMessageDelegate()?.showMessage(toastMessage)
                }
                guard let object = ObjectMapper.sharedInstance().objectFromSource(jsonDict, toInstanceOfClass: ObjectMerchantGroup.self) as? [ObjectMerchantGroup] else {
                    completion(merchantCampaigns: allCampaigns)
                    return
                }
                allCampaigns = object
            }
            
            completion(merchantCampaigns: allCampaigns)
            
            }, failure: {failureError in
                self.showMessageFromData(failureError.1 as! NSData)
                completion(merchantCampaigns: allCampaigns)
        })
    }

//    func getCampaignForId(campaignId : NSNumber, completion:(result : Bool) -> Void){
//        Alamofire.sharedInstance.startRequest(method: .POST, URLString: ApiWebURLs.getCampaignByCampaignId("\(campaignId)"), parameters:ApiParameters.getCampaignForIdParam(campaignId), encoding: .JSON, success: {JSON in
//            
//            DebugLogger.debugLog("JSON: \(JSON)")
//
//            completion(result: true)
//            
//            }, failure: {failureError in
//                completion(result : false)
//                DebugLogger.debugLog("failureError \(failureError)")
//        })
//    
//    }
    
    func getStoresForMerchant(merchantId : NSNumber, completion:(merchantStores : [ObjectMerchantStore]) -> Void){
        var allStores : [ObjectMerchantStore] = []

        Alamofire.sharedInstance.startRequest(method: .POST, URLString: ApiWebURLs.fetchMerchantStores("\(merchantId)"), parameters:ApiParameters.getMerchantParams(merchantId), encoding: .JSON, success: {JSON in
            
//            DebugLogger.debugLog("JSON: \(JSON)")
            
            if JSON![JSON_Keys.STORES] != nil {
                let jsonDict = JSON![JSON_Keys.STORES] as! [NSDictionary]
                guard let object = ObjectMapper.sharedInstance().objectFromSource(jsonDict, toInstanceOfClass: ObjectMerchantStore.self) as? [ObjectMerchantStore] else {
                    completion(merchantStores: allStores)
                    return
                }
                allStores = object
            }
            completion(merchantStores: allStores)
            
            }, failure: {failureError in
                self.showMessageFromData(failureError.1 as! NSData)
                completion(merchantStores: allStores)

        })
        
    }
}
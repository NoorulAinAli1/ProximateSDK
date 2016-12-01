//
//  ObjectMerchantGroup.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 06/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit


class ObjectMerchantGroup: NSObject {
    var merchantId          : NSNumber!
    var merchantName        : String!
    var sortOrder           : NSNumber!
    var activeCampaignCount : NSNumber!
    var campaigns           : [ObjectCampaign]!// = []
    
    override init(){
        super.init()
        
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectMerchantGroup else {
            return false
        }
        let lhs = self
        
        return lhs.merchantId == rhs.merchantId
    }
    
    func getMerchant() -> ObjectMerchant {
        return campaigns![0].getMerchant()
    }
    
    func getSortOrder() -> String {
        return "\(sortOrder)"
    }
}

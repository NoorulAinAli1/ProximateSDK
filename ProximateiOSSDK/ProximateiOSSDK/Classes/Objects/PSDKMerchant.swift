//
//  PSDKMerchant.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 01/12/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

internal class PSDKMerchant: NSObject {

    var apiExpiryDate       : NSNumber!
    var apiKey              : String!
    var merchantId          : NSNumber!
    var merchantName        : String!
    var message             : String!
    var packageName         : String!
   
    
    override init(){
        super.init()
    }
    
    func getMerchantId() -> NSInteger {
        return merchantId.integerValue
    }
}

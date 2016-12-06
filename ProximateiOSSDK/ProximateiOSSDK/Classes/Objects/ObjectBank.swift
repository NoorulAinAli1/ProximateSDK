//
//  ObjectBank.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class ObjectBank: NSObject {

    var merchantName            : String!
    var merchantLogoImagePath   : String!
    var cardMerchantId          : Int!
    var cards                   : [ObjectBankCard]?
    
    override init(){
        super.init()
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectBank else {
            return false
        }
        let lhs = self
        
        return lhs.cardMerchantId == rhs.cardMerchantId
    }
}

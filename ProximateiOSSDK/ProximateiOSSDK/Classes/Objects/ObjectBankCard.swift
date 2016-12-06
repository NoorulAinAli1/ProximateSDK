//
//  ObjectBankCard.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class ObjectBankCard: NSObject {
    var offerText       : String?
    var tagLine         : String?
    var cardTitle       : String!
    var campaignCardId  : Int!
    var isCreditCard    : NSNumber?
    
    override init(){
        super.init()
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectBankCard else {
            return false
        }
        let lhs = self
        
        return lhs.campaignCardId == rhs.campaignCardId
    }

}
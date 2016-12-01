//
//  ObjectCampaignAction.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 01/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit

class ObjectCampaignAction: NSObject {
    var actionType  : NSNumber!
    var actionClass : String!
    var actionTitle : String!
    var sortOrder   : NSNumber?
    var field1      : String?
    var field2      : String?
    var externalBrowser : Bool?
    var url         : String?

    var media       : [ObjectCampaignMedia] = []//CampaignMedia
    
    override init(){
        super.init()
    }
    
    init(dictionary : NSDictionary!) {
//        let json    = JSON(dictionary)
//        actionType  = json[JSON_Keys.CAMPAIGN_ACTION_TYPE].intValue
//        actionClass = json[JSON_Keys.CAMPAIGN_ACTION_CLASS].stringValue
//        actionTitle = json[JSON_Keys.CAMPAIGN_ACTION_TITLE].stringValue
//        sortOrder   = json[JSON_Keys.SORT_ORDER].intValue
//        media       = json["media"].stringValue
//        field1      = json[JSON_Keys.CAMPAIGN_ACTION_FIELD_1].stringValue
//        field2      = json[JSON_Keys.CAMPAIGN_ACTION_FIELD_2].stringValue
//        externalBrowser = json[JSON_Keys.CAMPAIGN_EXTERNAL_BROWSER].boolValue
//        url         = json[JSON_Keys.CAMPAIGN_ACTION_URL].stringValue
        
    }
}

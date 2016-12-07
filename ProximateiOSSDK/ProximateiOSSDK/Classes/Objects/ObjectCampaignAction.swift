//
//  ObjectCampaignAction.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 01/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit

internal class ObjectCampaignAction: NSObject {
    var actionType  : NSNumber!
    var actionClass : String!
    var actionTitle : String!
    var sortOrder   : NSNumber?
    var field1      : String?
    var field2      : String?
    var externalBrowser : NSNumber?
    var url         : String?

    var media       : [ObjectCampaignMedia] = []//CampaignMedia
    
    override init(){
        super.init()
    }
    
    func isExternalBrowser() -> Bool {
        return externalBrowser!.boolValue
    }
    
    func getURL() -> NSURL {
        var actionURL : String = self.url!
        if !actionURL.hasPrefix("http"){
            actionURL = "https://\(actionURL)"
        }
        return NSURL(string: actionURL)!
    }
    
    func getMapCoordinates() -> (lat: Double, lng: Double) {
        let locArray = field1!.componentsSeparatedByString(",")
        let lat = locArray[0].numberValue?.doubleValue
        let lng = locArray[1].numberValue?.doubleValue
        return (lat!, lng!)
    }
    
    func toString() -> String {
        return "\(actionType) - \(actionClass) - \(actionTitle) - \(sortOrder) - \(field1) - \(field2) - \(externalBrowser) - \(url)"
    }
    
}

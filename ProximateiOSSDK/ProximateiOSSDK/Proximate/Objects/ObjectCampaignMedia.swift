//
//  ObjectCampaignMedia.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 25/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

class ObjectCampaignMedia: NSObject {

    var type        : String!
    var path        : String!
    var title       : String?
    var sizeInBytes : String?
    var targetDevice: String?
    var sortOrder   : NSNumber!

    override init(){
        super.init()
        type = "6601"
        path = ""
        title = ""
        sortOrder = 1
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectCampaignMedia else {
            return false
        }
        let lhs = self
        
        return lhs.path == rhs.path
    }

    func getMediaURL() -> String {
        return path.urlEncoding()
    }
}

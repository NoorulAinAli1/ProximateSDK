//
//  ObjectGeoLocation.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 01/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit

internal class ObjectGeoLocation: NSObject {
    var latitude    : NSNumber?
    var longitude   : NSNumber?
    
    override init(){
        super.init()
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectGeoLocation else {
            return false
        }
        let lhs = self
        
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }

    
//    init(json : NSDictionary!) {
//        latitude    = json.objectForKey("y") as? Double
//        longitude   = json.objectForKey("x") as? Double
//    }
//    
}

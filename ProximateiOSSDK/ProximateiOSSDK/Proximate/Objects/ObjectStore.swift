//
//  ObjectStore.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 01/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit

class ObjectStore: NSObject {
    var storeId         : NSNumber!
    var storeName       : String!
    var impLocationId   : NSNumber!
    var impLocationName : String?
    var cityId          : NSNumber!
    var cityName        : String?
    var countryId       : NSNumber!
    var geoLocation     : ObjectGeoLocation!
    
    override init(){
        super.init()
    }
    
    func getLocation() -> String {
        return "\(geoLocation.latitude!), \(geoLocation.longitude!)"
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectStore else {
            return false
        }
        let lhs = self
        
        return lhs.storeId == rhs.storeId
    }

}


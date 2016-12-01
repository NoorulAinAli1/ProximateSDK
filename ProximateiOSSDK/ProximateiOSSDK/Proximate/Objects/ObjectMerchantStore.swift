//
//  ObjectMerchantStore.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 30/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

class ObjectMerchantStore: NSObject {
    var storeId         : NSNumber!
    var merchantStoreId : NSNumber!
    var storeTitle      : String?
    var locationLtLg    : String!
    var storeTiming     : String?
    var locationDesc    : String?
    var city            : String?
    var cityName        : String?
    var cityId          : NSNumber!
    var daysOfWeek      : NSNumber?
    var countryId       : NSNumber!
    var version         : NSNumber!
    var status      : NSNumber!
    
    override init(){
        super.init()
    }
    
    func getLocation() -> String {
        return "locationLtLg - \(locationLtLg)"
    }
    
    func getLatitude() -> Double {
        let locArray = locationLtLg!.componentsSeparatedByString(",")
        let number = locArray[0].numberValue
        return number!.doubleValue
    }
    
    func getLongitude() -> Double {
        let locArray = locationLtLg!.componentsSeparatedByString(",")
        let number = locArray[1].numberValue
        return number!.doubleValue
    }
  
    func getSnippet() -> String {
        return "\(locationDesc!), \(storeTiming), \(cityName!)"
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectStore else {
            return false
        }
        let lhs = self
        return lhs.storeId == rhs.storeId
    }

}

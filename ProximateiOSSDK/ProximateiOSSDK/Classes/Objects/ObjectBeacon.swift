//
//  ObjectBeacon.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 04/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit


class ObjectBeacon: NSObject {
    var beaconUUID      : String!
    var beaconMajorId   : Int!
    var beaconMinorId   : Int!
    var deviceMac       : String!
    var snoozeTime      : Int!
    var geoLocation     : ObjectGeoLocation!
    var storeDTO        : ObjectStore!
    var assignmentType  : Int?
    var tagName         : String?
    var rssi            : String?
  
    override init(){
        super.init()
    }
    
    func getGooglePlaceName() -> String{
        return "\(storeDTO.storeName), "
//        return "\(storeDTO.storeName), \(storeDTO.cityName!)\n"
    }
}

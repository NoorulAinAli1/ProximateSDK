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
    
//    init(dictionary : NSDictionary!) {
//        let json        = JSON(dictionary)
//        beaconUUID      = json["beaconUUID"].stringValue
//        beaconMajorId   = json["beaconMajorId"].intValue
//        beaconMinorId   = json["beaconMinorId"].intValue
//        deviceMac       = json["deviceMac"].stringValue
//        snoozeTime      = json["snoozeTime"].intValue
//        let gLocation   = json[JSON_Keys.GEO_LOCATION]
//        geoLocation     = ObjectGeoLocation(json: gLocation)
//        let sDTO        = json["storeDTO"]
//        storeDTO        = ObjectStore(json: sDTO)
//        assignmentType  = json["assignmentType"].intValue
//        tagName         = json["tagName"].stringValue
//        rssi            = json["rssi"].stringValue
//    }
    
    func getGooglePlaceName() -> String{
        return "\(storeDTO.storeName), "
//        return "\(storeDTO.storeName), \(storeDTO.cityName!)\n"
    }
}

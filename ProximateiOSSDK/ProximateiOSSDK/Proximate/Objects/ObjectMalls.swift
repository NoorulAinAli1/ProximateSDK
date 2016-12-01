//
//  ObjectMalls.swift
//  ProximateiOSSDK
// 
//  Created by Khurram Iqbal on 19/10/2015.
//  Copyright (c) 2015 Noor ul Ain Ali. All rights reserved.
//

import UIKit

class ObjectMalls : NSObject  {
    var impLocationName : String!
    var cityId: String!
    var cityName: String!
    var _id : String!
  
    override init(){
        super.init()
    }
    
    init (mall : NSDictionary!){
        impLocationName =  mall.valueForKey(JSON_Keys.IMP_LOCATION_NAME) as! String
        cityId = mall.valueForKey(JSON_Keys.CITY_ID) as! String
        cityName = mall.valueForKey(JSON_Keys.CITY_NAME) as! String
        _id = mall.valueForKey("_id") as! String
    }
}

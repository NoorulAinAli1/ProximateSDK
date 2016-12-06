//
//  ObjectCategory.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 24/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

class ObjectCategory: NSObject {
    
    var success : Bool?
    var prodCategoryId : NSNumber!
    var title : String!
    
    override init(){
        super.init()
        prodCategoryId  = 0
        title           = "All"
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectCategory else {
            return false
        }
        let lhs = self
        
        return lhs.prodCategoryId == rhs.prodCategoryId
    }

    
    func getCategoryTitle() -> String {
        return String(htmlEncodedString: title)
    }
    
    func toString() -> String {
        return "id: \(prodCategoryId) title: \(title)"
    }
}

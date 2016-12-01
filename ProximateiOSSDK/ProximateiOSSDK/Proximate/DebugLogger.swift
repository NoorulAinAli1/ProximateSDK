//
//  DebugLogger.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 24/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

class DebugLogger {
    class func print(object: Any) {
//        #if DEBUG
            Swift.print(object)
//        #endif
    }
    
    class func debugLog(object: Any) {
        //        #if DEBUG
        Swift.print(object)
        //        #endif
    }
    
    class func showToastMessage(object: String) {
        //        #if DEBUG
        Swift.print("----------------------\n\(object)\n----------------------")
        //        #endif
    }
}

//
//  DebugLogger.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 24/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

class DebugLogger {
    private static var loggingEnabled : Bool = true

    class func enableDebugMode(enable : Bool = false){
        DebugLogger.loggingEnabled = enable
    }
    
    class func debugLog(object: Any) {
        //        #if DEBUG
        if loggingEnabled {
            Swift.print(object)
        //        #endif
        }
    }
    
    class func showToastMessage(object: String) {
        //        #if DEBUG
        Swift.print("----------------------\n\(object)\n----------------------")
        //        #endif
    }
}

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
    private static var testingServer : Bool = false

    class func enableDebugMode(enable : Bool = false){
        DebugLogger.loggingEnabled = enable
    }
    
    class func enableDebugServer(enable : Bool = false){
        DebugLogger.testingServer = enable
    }

    class func debugLog(object: Any) {
        //        #if DEBUG
        if DebugLogger.loggingEnabled {
            Swift.print(object)
        //        #endif
        }
    }
    
    internal class func getServerUrl() -> String {
        let baseUrl : String =  DebugLogger.testingServer ? "http://125.209.114.194:8082/ProximateService/restsimple/" : "http://services.proximate.ae:8082/ProximateService/restsimple/"
        return baseUrl
    }

}

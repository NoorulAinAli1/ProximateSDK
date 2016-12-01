//
//  ProximateiOSSDK.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 24/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

@objc public protocol PSDKScreenInteractionDelegate {
    func screenInteracted()

}

@objc public protocol PSDKMessageDelegate {
    func showMessage(message : String)
}

public class ProximateiOSSDK: NSObject {
    private static let psdkMerchantKey  = "ProximateMerchantKey"
    private static var psdkBundleIdentifer : String!
    private static var screenInteractionDelegate : PSDKScreenInteractionDelegate?
    private static var messageDelegate : PSDKMessageDelegate?

    public static func initialize(messageDelegate msgDelegate : PSDKMessageDelegate? = nil, screenInteractionDelegate screenDelegate : PSDKScreenInteractionDelegate? = nil) {
        
        OCMapperConfig.configure()
        ProximateiOSSDK.messageDelegate             = msgDelegate
        ProximateiOSSDK.screenInteractionDelegate   = screenDelegate
        
        ProximateiOSSDK.psdkBundleIdentifer         = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleIdentifierKey as String) as! String
        DebugLogger.debugLog("bundleIdentifier \(ProximateiOSSDK.psdkBundleIdentifer)")
        
        let proximateApiKey                         = NSBundle.mainBundle().objectForInfoDictionaryKey(psdkMerchantKey) as? String
        DebugLogger.debugLog("proximateMerchantKey \(proximateApiKey)")
        
    }
    
    public static func getMessageDelegate() -> PSDKMessageDelegate? {
        return messageDelegate
    }
    
    public static func getScreenInteractionDelegate() -> PSDKScreenInteractionDelegate? {
        return screenInteractionDelegate
    }
    
    public static func openProximateSDK() -> UINavigationController {
        let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: NSBundle.mainBundle())
        let viewController = storyBoard.instantiateViewControllerWithIdentifier("ProximateSDKMainNav") as! UINavigationController
        return viewController
//        self.presentViewController(viewController, animated: true, completion: nil)
        //        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    public static func getPackageIdentifer() -> String {
        return ProximateiOSSDK.psdkBundleIdentifer!
    }
}

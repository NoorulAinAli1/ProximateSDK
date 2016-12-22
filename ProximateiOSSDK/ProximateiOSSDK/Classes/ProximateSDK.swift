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

@objc public enum PSDKMessageType : Int {
    case Message
    case Error
    case Progress
}

@objc public protocol PSDKMessageDelegate {
    func showMessage(message : String)
    func showMessage(message : String, forMessageType messageType : PSDKMessageType)

}

public class ProximateSDK: NSObject {
    private static let psdkMerchantKey  = "ProximateMerchantKey"
    private static let psdkCacheTime = "ProximateCacheTime"
    private static var psdkBundleIdentifer : String!
    private static var screenInteractionDelegate : PSDKScreenInteractionDelegate?
    private static var messageDelegate : PSDKMessageDelegate?
    private static var mPSDKValidated : Bool! = false

    
    public static func initialize(messageDelegate msgDelegate : PSDKMessageDelegate? = nil, screenInteractionDelegate screenDelegate : PSDKScreenInteractionDelegate? = nil) {
        
        ProximateSDK.psdkBundleIdentifer         = "com.proximate.app"//NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleIdentifierKey as String) as! String

        ProximateSDK.messageDelegate             = msgDelegate
        ProximateSDK.screenInteractionDelegate   = screenDelegate
        
        guard let proximateApiKey = NSBundle.mainBundle().objectForInfoDictionaryKey(psdkMerchantKey) as? String else {
            // show exception
            assertionFailure("ProximateiOSSDK api key not set in Info.plist with key 'ProximateMerchantKey'")
            return
        }
        
        ApiHandler.sharedInstance.verifyMerchant (proximateApiKey, completion: {
            result in
            ProximateSDK.mPSDKValidated = result
            ProximateSDKSettings.configure()
        })
    }
    
    public static func enableDebugLogging(enable : Bool = true) {
        DebugLogger.enableDebugMode(enable)
    }
    
    internal static func getMessageDelegate() -> PSDKMessageDelegate? {
        return messageDelegate
    }
    
    internal static func getScreenInteractionDelegate() -> PSDKScreenInteractionDelegate? {
        return screenInteractionDelegate
    }
    
    public static func openProximateSDK(viewController: UIViewController) {
        assert(ProximateSDK.mPSDKValidated.boolValue, "ProximateiOSSDK is not initialized")
        
        let storyBoard = UIStoryboard(name: "ProximateSDK", bundle: ProximateSDKSettings.getBundle())
        let proximateViewController = storyBoard.instantiateViewControllerWithIdentifier("ProximateSDKMainNav") as! UINavigationController
        viewController.presentViewController(proximateViewController, animated: true, completion: nil)
    }
    
    internal static func getPackageIdentifer() -> String {
        return ProximateSDK.psdkBundleIdentifer!
    }
    
    internal static func getCacheTime() -> Int {
        guard let cacheTime = NSBundle.mainBundle().objectForInfoDictionaryKey(psdkCacheTime) as? NSInteger else {
           
            return 24 * 60 * 60
        }
        return cacheTime
    }
    
    internal static func getAppName() -> String {
        return NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleNameKey as String) as! String
    }
}

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

public enum CAMPAIGN_MEDIA_TYPE : Int {
    case Image  = 6601
    case Video  = 6602
    case PDF    = 6603
    case Word   = 6604
    case Doc    = 6605
    case PPT    = 6606
}

public enum CAMPAIGN_ACTION_TYPE : String {
    case IMAGELIST  = "ImageList"
    case VIDEO      = "Video"
    case URL        = "URL"
    case MAP        = "MAP"
    case REDEEM     = "REDEEM"
}

public class ProximateSDK: NSObject {
    private static let psdkMerchantKey  = "ProximateMerchantKey"
    private static var psdkBundleIdentifer : String!
    private static var screenInteractionDelegate : PSDKScreenInteractionDelegate?
    private static var messageDelegate : PSDKMessageDelegate?
    private static var mPSDKValidated : Bool! = false
  
    public static func initialize(messageDelegate msgDelegate : PSDKMessageDelegate? = nil, screenInteractionDelegate screenDelegate : PSDKScreenInteractionDelegate? = nil) {
        
        ProximateSDK.psdkBundleIdentifer         = NSBundle.mainBundle().objectForInfoDictionaryKey(kCFBundleIdentifierKey as String) as! String

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
    
<<<<<<< HEAD
=======
    private static func initializeFonts() {
//        UILabel.appearance().sdkFontName = "Futura"
    }
    
>>>>>>> 0fdc7c6e75a293416616ee6dd86ce04d767d1548
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
}

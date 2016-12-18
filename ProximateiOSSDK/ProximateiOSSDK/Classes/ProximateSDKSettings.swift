//
//  ProximateSDKSettings.swift
//  Pods
//
//  Created by NoorulAinAli on 08/12/2016.
//
//

import UIKit

internal class ProximateSDKSettings: NSObject {

    static func configure() {
        OCMapperConfig.configure()
        
        initializeFonts()
    }
    
    internal static func getBoldFontName() -> String {
        return "Futura-CondensedExtraBold"
    }

    internal static func getFontName() -> String {
        return "Futura"
    }
    
    private static func initializeFonts() {
        
        UIButton.appearance().sdkFontName = "Futura"
        UITextField.appearance().sdkFontName = "Futura"

//        UILabel.appearance().sdkFontName = "Futura"
//        UILabel.appearance().sdkBoldFontName = "Futura-CondensedExtraBold"
    }
    
    internal static func getBundle() -> NSBundle {
        let podBundle = NSBundle(forClass: self.classForCoder())
        let bundleURL = podBundle.URLForResource("ProximateiOSSDK", withExtension: "bundle")
        guard let bundle = NSBundle(URL: bundleURL!) else {
            assertionFailure("Couldn't load ProximateiOSSDK bundle")
            return NSBundle.mainBundle()
        }
        //            assertionFailure("Could not create a path to the bundle")
        return bundle
    }
    
    internal static func getImageForName(name : String) -> UIImage {
        guard let appImage = UIImage(named: name, inBundle: NSBundle.mainBundle(), compatibleWithTraitCollection: nil) else {
           return UIImage(named: name, inBundle: ProximateSDKSettings.getBundle(), compatibleWithTraitCollection: nil)!
        }

        return appImage
    }
    
    internal static func getCampaignPlaceholderImage() -> UIImage {
        return ProximateSDKSettings.getImageForName("placeholder_campaign")
    }
    
    internal static func getLoadingPlaceholderImage() -> UIImage {
        return ProximateSDKSettings.getImageForName("placeholder_loading")
    }
}

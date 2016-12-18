//
//  AppDelegate.swift
//  ProximateiOSSDK
//
//  Created by noorulain.ali on 12/07/2016.
//  Copyright (c) 2016 noorulain.ali. All rights reserved.
//

import UIKit
import ProximateiOSSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PSDKMessageDelegate, PSDKScreenInteractionDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
//        // Customize menu (Optional)
//        let tabParameters: [PSDKTabOption] = [
//            .SelectedMenuColor(UIColor.purpleColor()),
//            .UnselectedMenuColor(UIColor.cyanColor()),
//            .ViewBackgroundColor(UIColor.blackColor()),
//            .MenuMarginX(10),
//            .MenuMarginY(20),
//            .MenuItemFontSize(14.0),
//            .MenuHeight(60.0),
//            .MenuItemSelectedBorderColor(UIColor.whiteColor()),
//            .MenuItemUnselectedBorderColor(UIColor.purpleColor()),
//            .MenuItemBorderWidth(2.5),
//            //            .MenuItemWidthBasedOnTitleTextWidth(true),
//            .UnselectedMenuItemLabelColor(UIColor.blueColor()),
//            .SelectedMenuItemLabelColor(UIColor.orangeColor())
//        ]
//        
//        ProximateSDKSettings.setTabStyleOptions(tabParameters)
//        
//        let cardParameters : [PSDKCardOptions] = [
//            .CardBackgroundColor(UIColor.whiteColor()),
//            .CardShadowColor(UIColor.grayColor()),
//            .CardBorderColor(UIColor.blackColor()),
//            .CardShadowOffset(CGSizeMake(2, 4)),
//            .CardBorderWidth(0.2),
//            .CardCornerRadius(4.0),
//            .CardShadowRadius(2.0),
//            .CardShadowOpacity(2.5)
//        ]
//        ProximateSDKSettings.setCardOptions(cardParameters)
//        
//        let viewParameters : [PSDKViewOptions] = [
//            .ViewBackgroundColor(UIColor.lightGrayColor()),
//            .NavigationBarTitle(UIColor.whiteColor(), 13.0),
//            .NavigationBarTintColor(UIColor.whiteColor()),
//            .PrimaryColor(UIColor.redColor()),
//            .SearchBar(UIColor.brownColor()),
//            .Font("Futura", "Futura-CondensedExtraBold")
//        ]
//        
//        ProximateSDKSettings.setViewOptions(viewParameters)
//        
//        let fontParameters : [PSDKFontStyleOptions] = [
//            .SeeAllFontStyle(UIColor.blueColor(), 12.0),
//            .MerchantTitleFontStyle(UIColor.brownColor(), 16.0),
//            .ExpiryTextFontStyle(UIColor.cyanColor(), UIColor.blueColor(), 14.0),
//            .CampaignTitleFontStyle(UIColor.brownColor(), UIColor.blueColor(), 20.0),
//            .CampaignDetailFontStyle(UIColor.brownColor(), 18.0, UIColor.cyanColor(), 14.0)
//        ]
//
//        ProximateSDKSettings.setFontStyleOptions(fontParameters)

        ProximateSDKSettings.configureSettingsPlist("PSDKSettings")
        ProximateSDK.initialize(messageDelegate: self, screenInteractionDelegate: self)
        
//        UILabel.appearance().font = UIFont(name: "Arial", size: 24)
//        UIButton.appearance().titleLabel?.font = UIFont(name: "Arial", size: 24)

        return true
    }
    
    func showMessage(message: String) {
        // show message here
        print("message \(message)")
    }

    func showMessage(message: String, forMessageType : PSDKMessageType) {
        // show message here
        print("message \(message), and type \(forMessageType)")
    }
    
    func screenInteracted() {
        // screenInteracted
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


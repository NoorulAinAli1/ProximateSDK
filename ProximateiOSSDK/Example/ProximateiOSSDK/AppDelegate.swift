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
        
        ProximateSDKSettings.setCampaignSectionSequence([CampaignSectionSequence.Timing,  CampaignSectionSequence.Bank, CampaignSectionSequence.Store, CampaignSectionSequence.Detail])
        let appPrimaryColor = UIColor(red: 0.776, green: 0.090, blue: 0.149, alpha: 1.0)


//    let tabParameters: [PSDKTabOption] = [
//        .ViewBackgroundColor(UIColor.blackColor()), // tab-background color
//        .MenuMargin(10, 20), // menu-margin-x, menu-margin-y
//        .MenuItemFontSize(14.0), // tab-font-size
//        .MenuHeight(60.0), // horizontal-tabs-view height
//        .MenuItemBorderColor(UIColor.whiteColor(), UIColor.purpleColor()), // tab-border-color-selected, tab-border-color-selected
//        .MenuItemBorderWidth(2.5), // tab-border-width
//        .MenuItemLabelColor(UIColor.orangeColor(), UIColor.blueColor()), // tab-text-color-selected, tab-text-color-unselected
//        .MenuItemBackgroundColor(UIColor.purpleColor(), UIColor.cyanColor())
//        // tab-background-color-selected, tab-background-color-unselected
//    ]
//        
//    ProximateSDKSettings.setTabStyleOptions(tabParameters)
//        
//        let cardParameters : [PSDKCardOptions] = [
//            .CardBackgroundColor(UIColor.whiteColor()), // card-background-color
//            .CardShadowColor(UIColor.lightGrayColor()), // card-shadow-color
//            .CardBorderColor(UIColor.blackColor()), // card-border-color
//            .CardShadowOffset(CGSizeMake(2, 4)), // card-shadowOffset-size
//            .CardBorderWidth(0.2), // card-border-width
//            .CardCornerRadius(4.0), // card-corner-radius
//            .CardShadowRadius(2.0) // card-shadow-radius
//        ]
//        ProximateSDKSettings.setCardOptions(cardParameters)
////
//        let viewParameters : [PSDKViewOptions] = [
//            .ViewBackgroundColor(UIColor.lightGrayColor()),//view background color
//            .NavigationBarTitle(UIColor.whiteColor(), 16.0),//navigationBar title-color, navigationBar title size
//            .NavigationBarTintColor(UIColor.whiteColor()),//navigationBar tint color
//            .PrimaryColor(UIColor.redColor()), //primary-color of sdk
//            .SearchBar(UIColor.redColor()), // background-color of search-bar
//            .Font("TrebuchetMS", "TrebuchetMS-Bold") // fontRegular, fontBold
//            .Padding(4.0, 10.0) // innerPadding, outerPadding
//            .CardHeight(CGFloat(200.0)) // card height for merchant and campaign
//            .HeaderHeight(CGFloat(300.0)) // header height for merchant and campaign
//        ]
//        
//        ProximateSDKSettings.setViewOptions(viewParameters)
//        
//        
//        let fontParameters : [PSDKFontStyleOptions] = [
//            .SeeAllFontStyle(appPrimaryColor, 14.0),//text-color, text-size
//            .MerchantTitleFontStyle(UIColor.blackColor(), 16.0),//text-color, text-size
//            .ExpiryTextFontStyle(UIColor.darkGrayColor(), UIColor.lightGrayColor(), 14.0),//text-color, expired-text-color, text-size
//            .CampaignTitleFontStyle(UIColor.redColor(), UIColor.redColor(), 20.0),//text-color, text-bold-color, text-size
//            .CampaignDetailFontStyle(UIColor.blackColor(), 16.0, UIColor.darkGrayColor(), 14.0)
//            //title-text-color, title-text-size, detail-text-color, detail-text-size
//        ]
//
////        ProximateSDKSettings.setFontStyleOptions(fontParameters)
//        
//            let pageIndicatorParameters : [PSDKPageIndicatorOptions] = [
//                .PageIndicatorDiameter(20.0), //page-indicator-diameter
//                .PageIndicatorSpace(2.0), //spacing between consecutive-page-indicators
//                .PageIndicatorColor(UIColor.purpleColor(), UIColor.cyanColor())
//                // page-indicator-color-selected, page-indicator-color-unselected
//            ]
//
//            ProximateSDKSettings.setPageIndicatorOptions(pageIndicatorParameters)
        

        ProximateSDKSettings.configureSettingsPlist("PSDKSettings")

        ProximateSDK.initialize(messageDelegate: self, screenInteractionDelegate: self)
        
//        UILabel.appearance().font = UIFont(name: "Arial", size: 24)
//        UIButton.appearance().titleLabel?.font = UIFont(name: "Arial", size: 24)

        ProximateSDK.enableDebugLogging(true)
        
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


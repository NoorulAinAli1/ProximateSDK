//
//  ObjectCampaign.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 04/04/2016.
//  Copyright © 2016 Noor ul Ain Ali. All rights reserved.
//

import UIKit

class ObjectCampaign: NSObject {
    
    var campaignId          : NSNumber!
    var summary             : String?
    var title               : String!
    var formattedTitle      : String?
    var details             : String!
    var popupText           : String!
    var popupImagePath      : String!
    var snoozeTimeInMinutes : NSNumber!
    var campaignLayout      : String!

    var beacons             : [ObjectBeacon]?  = []         // ProximateBeacon
    var contents            : [ObjectCampaignMedia]!    // CampaignMedia
    var campaignCards       : [ObjectBank]?             // CampaignCards
    var campaignTimings     : [ObjectCampaignTiming]?   // CampaignTiming
    var campaignActions     : [ObjectCampaignAction]?   // CampaignAction
//    var likesPicArray       : [String]    // String
    var merchant            : ObjectMerchant!
  
    var startDateTime       : String!
    var expiryDateTime      : String!
    
    var likesCount : NSNumber!
    var commentsCounts : NSNumber!
    var shareCount : NSNumber!
    var seenCount : NSNumber!
    var status : NSNumber!

    var isAdd : Bool!
    var isFav : Bool!
    var isCommented : Bool!
    var isShared : Bool!
    var isLiked : Bool!

    var redeemedDate : String?
    var redeemReferenceNumber : String?

    override init(){
        super.init()
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectCampaign else {
            return false
        }
        let lhs = self
        
        return lhs.campaignId == rhs.campaignId
    }
    
    func getCampaignId () -> NSInteger {
        return campaignId.integerValue
    }

    func getCampaignTitle () -> String {
        return title
    }

    func getExpiryTime() -> String {
        return expiryDateTime
    }
    
    func isExpired() -> Bool {
        return DateTimeUtility.isExpiredDate(expiryDateTime)
    }
    
    func getCampaignExpiryStyle() -> (campaignExpiryText : String, campaignExpiryImage : UIImage , campaignExpiryTextColor : UIColor) {
        let isExpired = self.isExpired()
        let campaignExpiryText = isExpired ? String(format: "text_expired_on".localized, arguments: [self.getExpiryDateTime()]) : String(format: "text_ends_on".localized, arguments: [self.getExpiryDateTime()])
        let campaignExpiryTextColor = isExpired ? UIColor.lightGrayColor() : UIColor.psdkPrimaryColor()
        let imageName = isExpired ? "time_icon_gray" : "time_icon_gray"//"time_icon_orange"
        let campaignExpiryImage = UIImage(named: imageName)!

        return (campaignExpiryText, campaignExpiryImage, campaignExpiryTextColor)
    }
    
    func getExpiryDateTime() -> String {
        return DateTimeUtility.getDateAsCompleteEndingDate(expiryDateTime)
    }
    
    func getMerchant () -> ObjectMerchant {
        return merchant
    }
    
    func getMerchantLogo () -> String {
        return merchant.merchantLogoPath
    }
    
    func getMainMedia() -> ObjectCampaignMedia {
        return self.contents.first ?? ObjectCampaignMedia()
    }
    
    func getMedia() -> [ObjectCampaignMedia]{
        self.contents.sortInPlace { $0.sortOrder.compare($1.sortOrder) == .OrderedAscending }
        return self.contents
    }
    
    func getTiming() -> [ObjectCampaignTiming]{
//        self.campaignTimings!.sortInPlace { $0.day.compare($1.day) == .OrderedAscending }
        return self.campaignTimings!
    }
    
}

//
//  ObjectCampaignTiming.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 29/11/2016.
//  Copyright © 2016 Proximate. All rights reserved.
//

import UIKit

internal class ObjectCampaignTiming: NSObject {
    var startTime           : String!
    var startTime2          : String?
    var endTime             : String!
    var endTime2            : String?
    var day                 : NSNumber!
    var campaignTimingId    : NSNumber!
    
    private let StoreStartTime1  = "00:00:00"
    private let StoreEndTime1    = "12:00:00"
    private let StoreEndTime2    = "23:59:00"
    private let days = ["Default", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    override init(){
        super.init()
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? ObjectCampaignTiming else {
            return false
        }
        let lhs = self
        
        return lhs.campaignTimingId == rhs.campaignTimingId
    }

    private func isFullDay() -> Bool {
        return self.isFullFirstHalf() && self.isFullSecondHalf()
    }
    
    private func isFullFirstHalf() ->  Bool {
        return startTime == StoreStartTime1 && endTime == StoreEndTime1
    }
    
    private func isFullSecondHalf() -> Bool {
        return startTime2 == StoreEndTime1 && endTime2 == StoreEndTime2
    }
    
    internal func getDay() -> String {
        return days[day.integerValue]
    }
    
    internal func getIsSingleLine() -> Bool {
        return isFullDay() || startTime2 == endTime// check for startTime2
    }
    
    internal func getTiming() -> String {
        var timingText =  "\(startTime) - \(endTime)\n\(startTime) - \(endTime)"
    
        if (isFullDay()) {
            timingText = "\("psdk_text_whole_day".localized)"
        } else if (startTime2 == endTime) {// check for startTime2
            timingText = "\(startTime) - \(endTime2)"
        } else {
            timingText =  "\(startTime) - \(endTime)\n\(startTime) - \(endTime)"
        }
        return timingText;
    }
}
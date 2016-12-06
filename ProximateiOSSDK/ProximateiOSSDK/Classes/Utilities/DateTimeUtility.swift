//
//  DateTimeUtility.swift
//  ProximateiOSSDK
//
//  Created by NoorulAinAli on 25/11/2016.
//  Copyright © 2016 ProximateiOSSDK. All rights reserved.
//

import UIKit

class DateTimeUtility: NSObject {
    static func isExpiredDate(stringDate : String) -> Bool{
        if stringDate.utf16.count == 0 {
            return false
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()//(name: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.dateFromString(stringDate)
        let currentDate =  NSDate()
        let comparisionResult = currentDate.compare(date!)
        if comparisionResult == .OrderedAscending {
            return false
        } else if comparisionResult == .OrderedSame{
            return true
        } else {
            return true
        }
        
    }
    static func hasStarted(stringDate : String , endDate : String) -> Bool{
        if stringDate.utf16.count == 0 || endDate.utf16.count == 0 {
            return false
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()//(name: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.dateFromString(stringDate)
        
        let currentDate =  NSDate()
        
        let comparisionResult = currentDate.compare(date!)
        if comparisionResult == .OrderedSame{
            return true
        }
            
        else if comparisionResult == .OrderedDescending {
            let endFormattedDate = dateFormatter.dateFromString(endDate)
            let newComparisionResult =  currentDate.compare(endFormattedDate!)
            
            if newComparisionResult == .OrderedAscending {
                return true
            } else if newComparisionResult == .OrderedSame{
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    static func isNew(stringDate : String) -> Bool{
        
        if stringDate.utf16.count == 0 {
            return false
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()//(name: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.dateFromString(stringDate)!
        
        let calendar = NSCalendar.currentCalendar().dateByAddingUnit(NSCalendarUnit.Day, value: -1*3, toDate: NSDate(), options: NSCalendarOptions.init(rawValue: 0))!
        //        DLog.println("calendar \(calendar)")
        //        DLog.println("date \(date)")
        let comparisionResult = calendar.compare(date)
        if comparisionResult == .OrderedSame{
            return true
        } else if comparisionResult == .OrderedAscending {
            return true
        } else {
            return false
        }
    }
    
    static func getCurrentDateTimestamp()-> String {
        let date = NSDate()
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()//(name: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateString = dateFormatter.stringFromDate(date)
        return dateString
    }
    
    static func getCurrentDay() -> String {
        let date = NSDate()
        let dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "EEEE"
        let dateString = dateFormatter.stringFromDate(date)
        return dateString
    }

    static func getDateAsEndingDateFromDate(date :NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()//(name: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return DateTimeUtility.getDateAsEndingDate(dateFormatter.stringFromDate(date))
    }
    
    static func getStringAsDate(dateStr : String) -> NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEE MMM dd, yyyy"
        return  dateFormatter.dateFromString(dateStr)!
    }
    
    static func getDateFromString(dateStr : String) -> NSDate {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return  dateFormatter.dateFromString(dateStr)!
        
    }
    
    static func getCurrentDateAsEndingDate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "EEE MMM dd, yyyy"
        return dateFormatter.stringFromDate(NSDate())
    }
    
    static func getOnlyCurrentTime() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "h:mm:ss a"
        return dateFormatter.stringFromDate(NSDate())
    }
    
    static func getOnlyCurrentDate() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.stringFromDate(NSDate())
    }
    
    
    static func getDateAsEndingDate(enddate :String) -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date : NSDate =  dateFormatter.dateFromString(enddate)!
        dateFormatter.dateFormat = "EEE MMM dd, yyyy"
        
        return dateFormatter.stringFromDate(date)
    }
    
    static func getDateAsCompleteEndingDate(var enddate :String) -> String {
        
        if enddate.utf16.count == 0 {
            enddate = getCurrentDateTimestamp()
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date : NSDate =  dateFormatter.dateFromString(enddate)!
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "EEE MMM dd, yyyy hh:mm a"
        
        return dateFormatter.stringFromDate(date)
    }
        
        
}
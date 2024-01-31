//
//  Date+Ext.swift
//  Navigate
//
//  Created by Aakif Nadeem on 26/01/2023.
//

import Foundation


extension Date {
    static func getFormattedDate(string: String , format: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = AppConstants.UTCFormat
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        dateFormatterPrint.amSymbol = "am"
        dateFormatterPrint.pmSymbol = "pm"
        
        let date: Date? = dateFormatterGet.date(from: string)?.toLocalTime()
        return dateFormatterPrint.string(from: date!);
    }
    
    // Convert UTC (or GMT) to local time
    func toLocalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    // Convert local time to UTC (or GMT)
    func toGlobalTime() -> Date {
        let timezone = TimeZone.current
        let seconds = -TimeInterval(timezone.secondsFromGMT(for: self))
        return Date(timeInterval: seconds, since: self)
    }
    
    func getCurrentTime() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = AppConstants.DateTimeFormat
        
        let dateString = dateFormatterGet.string(from: Date())
        return dateString
    }
    
    func getCurrentDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = AppConstants.CompactDateFormat
        
        let dateString = dateFormatterGet.string(from: Date())
        return dateString
    }
}

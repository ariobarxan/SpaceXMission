//
//  DateExtension.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/22/23.
//

import Foundation

extension Date {
    
    enum Formats: String {
        case dateWith12HourClock = "MM/dd/yyyy HH:mm:ss a"
        case dateWith24HourClock = "MM/dd/yyyy HH:mm:ss"
        case monthDayYear = "MM/dd/yyyy"
        case yearMonthDay = "yyyy-MM-dd"
        case dayMonthYear = "dd MMMM yyyy"
        case isoWithoutTimeOffset = "yyyy-MM-dd'T'HH:mm:ss"
        case isoWithTimeZoneOffset = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        case isoWithMiliSecondsAndTimeZoneOffset = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    }
    
    static func getFormattedDate(_ wantedDateFormate: Date.Formats = .dayMonthYear,from dateString: String) -> String? {
        guard let currentDateFormat = Date.detectDateFormat(dateString) else {return nil}
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = currentDateFormat
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = wantedDateFormate.rawValue
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            let formattedDate = dateFormatter.string(from: date)
            return formattedDate
        } else {
            return nil
        }
    }
    
    static func detectDateFormat(_ dateString: String) -> String? {
        let dateFormats = [
            Date.Formats.isoWithMiliSecondsAndTimeZoneOffset.rawValue,
            Date.Formats.isoWithTimeZoneOffset.rawValue,
            Date.Formats.isoWithoutTimeOffset.rawValue,
            Date.Formats.yearMonthDay.rawValue,
            Date.Formats.monthDayYear.rawValue,
            Date.Formats.dayMonthYear.rawValue,
            Date.Formats.dateWith24HourClock.rawValue,
            Date.Formats.dateWith12HourClock.rawValue
        ]
        
        for format in dateFormats {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            if dateFormatter.date(from: dateString) != nil {
                return format
            }
        }
        return nil
    }
}

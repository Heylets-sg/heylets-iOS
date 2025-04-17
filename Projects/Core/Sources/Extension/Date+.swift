//
//  Date+.swift
//  Core
//
//  Created by 류희재 on 1/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

extension Date {
    public func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd" // 원하는 형식
        let dateString = formatter.string(from: self)
        return dateString
    }
    
    public func timeToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
    
    public func timeToString24() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter.string(from: self)
    }
    
    public static func fromTimeString(_ timeString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        // Try 12-hour format first
        formatter.dateFormat = "a hh:mm"
        if let date = formatter.date(from: timeString) {
            return date
        }
        
        // Try 24-hour format
        formatter.dateFormat = "HH:mm"
        return formatter.date(from: timeString)
    }
}


public extension String {
    func parseTime() -> (hour: Int, minute: Int) {
        let components = self.split(separator: ":").compactMap { Int($0) }
        guard components.count == 2 else { return (hour: 0, minute: 0) }
        return (hour: components[0], minute: components[1])
    }
    
    func stringToTime() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm" // 24시간제 형식
        formatter.locale = Locale(identifier: "en_US_POSIX") // 일관된 형식 유지
        formatter.timeZone = TimeZone.current // 현재 타임존 설정
        return formatter.date(from: self) ?? Date()
    }
}

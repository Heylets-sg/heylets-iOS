//
//  ScheduleMapper.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension SchedulesResult {
    func toEntity()-> ScheduleInfo {
        let startTimeComponents = parseTime(startTime)
        let endTimeComponents = parseTime(endTime)
        let weekDay = convertToWeek(from: classDay)
        
        return .init(
            id: scheduleId,
            day: weekDay,
            startHour: startTimeComponents.hour,
            startMinute: startTimeComponents.minute,
            endHour: endTimeComponents.hour,
            endMinute: endTimeComponents.minute,
            location: location
        )
    }
    
    private func parseTime(_ time: String) -> (hour: Int, minute: Int) {
        let components = time.split(separator: ":").compactMap { Int($0) }
        guard components.count == 2 else { return (hour: 0, minute: 0) }
        return (hour: components[0], minute: components[1])
    }
    
    private func convertToWeek(from day: String) -> Week {
        switch day {
        case "Monday": return .Mon
        case "Tuesday": return .Tue
        case "Wednesday": return .Wed
        case "Thursday": return .Thu
        case "Friday": return .Fri
        case "Saturday": return .Sat
        case "Sunday": return .Sun
        default: return .Mon
        }
    }
}


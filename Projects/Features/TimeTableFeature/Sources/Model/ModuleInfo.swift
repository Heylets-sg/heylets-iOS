//
//  ModuleInfo.swift
//  TimeTableFeatureInterface
//
//  Created by 류희재 on 1/2/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct ModuleInfo {
    var code: String
    var name: String
    var schedule: [ScheduleInfo]
    var professor: String?
    var unit: Int
    
    var allscheduleTime: String {
        let all = schedule.map { "\($0.day) \($0.startTime) - \($0.endTime)" }
        return all.joined(separator: ", ")
    }
    
    var location: String {
        let locationList = Dictionary(grouping: schedule) { $0.location }
        let list =  locationList.map { location, schedule in
            if schedule.allSatisfy({$0.location == schedule.first!.location}) {
                return location
            } else {
                let days = schedule.map { $0.day }.joined(separator: ", ")
                return "\(location)(\(days))"
            }
        }
        return list.joined(separator: ", ")
    }
}

struct ScheduleInfo {
    var day: String
    var startTime: String
    var endTime: String
    var location: String
}

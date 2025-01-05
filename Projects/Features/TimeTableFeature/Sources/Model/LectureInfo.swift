//
//  ModuleInfo.swift
//  TimeTableFeatureInterface
//
//  Created by 류희재 on 1/2/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct LectureInfo: Hashable {
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
                let days = schedule.map { $0.day.rawValue }.joined(separator: ", ")
                return "\(location)(\(days))"
            }
        }
        return list.joined(separator: ", ")
    }
}

extension LectureInfo {
    static var stub: Self {
        .init(
            code: "EE3101",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2], 
            professor: "TUT-EE04",
            unit: 2
        )
    }
}

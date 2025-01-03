//
//  SceduleInfo.swift
//  TimeTableFeatureInterface
//
//  Created by 류희재 on 1/3/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct ScheduleInfo {
    var id: Int
    var day: Week
    var startHour: Int
    var startMinute: Int
    var endHour: Int
    var endMinute: Int
    var location: String
    
    var startTime: String {
        return "\(startHour):\(startMinute)"
    }
    
    var endTime: String {
        return "\(endHour):\(endMinute)"
    }
}

extension ScheduleInfo {
    static var stub1: Self {
        .init(
            id: 3,
            day: .Tue,
            startHour: 10,
            startMinute: 30,
            endHour: 11,
            endMinute: 50,
            location: "TR+67"
        )
    }
    
    static var stub2_1: Self {
        .init(
            id: 1,
            day: .Thu,
            startHour: 9,
            startMinute: 30,
            endHour: 11,
            endMinute: 20,
            location: "SPMS-LT3"
        )
    }
    
    static var stub2_2: Self {
        .init(
            id: 2,
            day: .Mon,
            startHour: 9,
            startMinute: 30,
            endHour: 11,
            endMinute: 20,
            location: "SPMS-TR+6"
        )
    }
}

//
//  ScheduleInfo_Stub.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

extension ScheduleInfo {
    static var stub1: Self {
        .init(
            id: 3,
            day: .Tue,
            startHour: 10,
            startMinute: 0,
            endHour: 12,
            endMinute: 0,
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
            endMinute: 30,
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
            endMinute: 30,
            location: "SPMS-TR+6"
        )
    }
    
    static var stub3: Self {
        .init(
            id: 2,
            day: .Sat,
            startHour: 9,
            startMinute: 30,
            endHour: 11,
            endMinute: 30,
            location: "SPMS-TR+6"
        )
    }
    
    static var stub4: Self {
        .init(
            id: 2,
            day: .Sun,
            startHour: 9,
            startMinute: 30,
            endHour: 11,
            endMinute: 30,
            location: "SPMS-TR+6"
        )
    }
}

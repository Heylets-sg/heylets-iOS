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
        let startTimeComponents = startTime.parseTime()
        let endTimeComponents = endTime.parseTime()
        let weekDay = Week.toWeek(from: classDay)
        
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
}


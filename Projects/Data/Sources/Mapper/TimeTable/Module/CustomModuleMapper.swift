//
//  CustomModuleMapper.swift
//  Data
//
//  Created by 류희재 on 1/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension CustomModuleResult {
    func toEntity() -> SectionInfo {
        let startTimeComponents = startTime.parseTime()
        let endTimeComponents = endTime.parseTime()
        let weekDay = Week.convertToWeek(from: classDay)
        
        return .init(
            id: scheduleId,
            name: title,
            schedule: [.init(
                day: weekDay,
                startHour: startTimeComponents.hour,
                startMinute: startTimeComponents.minute,
                endHour: endTimeComponents.hour,
                endMinute: endTimeComponents.minute,
                location: location
            )],
            professor: professor,
            memo: memo
        )
    }
    
    func toEntity() -> CustomModuleInfo {
        .init(
            scheduleId: scheduleId,
            title: title,
            location: location,
            professor: professor,
            classDay: classDay,
            startTime: startTime,
            endTime: endTime,
            memo: memo
        )
    }
}

extension CustomModuleInfo {
    func toDTO() -> CustomModuleRequest {
        .init(
            title: title,
            location: location,
            professor: professor,
            day: classDay,
            startTime: startTime,
            endTime: endTime,
            memo: memo
        )
    }
}

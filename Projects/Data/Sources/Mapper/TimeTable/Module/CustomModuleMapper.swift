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
        let weekDay = Week.toWeek(from: classDay)
        
        return .init(
            id: scheduleId,
            name: title,
            schedule: [.init(
                day: weekDay,
                startHour: startTimeComponents.hour,
                startMinute: startTimeComponents.minute,
                endHour: endTimeComponents.hour,
                endMinute: endTimeComponents.minute,
                location: location ?? ""
            )],
            professor: professor ?? "",
            unit: endTimeComponents.hour - startTimeComponents.hour, //그냥 시간으로 표시
            memo: memo,
            backgroundColor: displayStyle.backgroundColor,
            textColor: displayStyle.textColor,
            isCustom: true
        )
    }
    
    func toEntity() -> CustomModuleInfo {
        .init(
            title: title,
            classDay: classDay,
            startTime: startTime,
            endTime: endTime,
            location: location,
            professor: professor
        )
    }
}

extension CustomModuleInfo {
    func toDTO() -> CustomModuleRequest {
        .init(
            title: title,
            day: classDay,
            startTime: startTime,
            endTime: endTime,
            location: location,
            professor: professor,
            memo: memo
        )
    }
}

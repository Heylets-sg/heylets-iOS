//
//  ModuleMapper.swift
//  Data
//
//  Created by 류희재 on 1/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension ModuleResult {
    func toEntity() -> ModuleInfo {
        .init(
            scheduleId: scheduleId,
            courseCode: courseCode, //이 부분 조심
            sectionCode: sectionCode, //이 부분 조심
            location: location,
            professor: professor,
            classDay: classDay,
            startTime: startTime,
            endTime: endTime
        )
    }
}



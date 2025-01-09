//
//  SectionMapper.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension SectionResult {
    func toEntity() -> SectionInfo {
        .init(
            id: sectionCode,
            code: courseCode!,
            name: courseName!,
            schedule: schedules.map { $0.toEntity() },
            professor: professor,
            unit: nil
        )
    }
    
    func toEntity(_ unit: Int) -> SectionInfo {
        .init(
            id: sectionCode,
            code: courseCode!,
            name: courseName!,
            schedule: schedules.map { $0.toEntity() },
            professor: professor,
            unit: unit
        )
    }
    
    func toEntity(_ code: String, _ name: String) -> SectionInfo {
        .init(
            id: sectionCode,
            code: code,
            name: name,
            schedule: schedules.map { $0.toEntity() }
        )
    }
}

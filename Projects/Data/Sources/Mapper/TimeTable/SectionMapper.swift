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
            id: sectionId,
            code: courseCode!, //TODO: sectionCode랑 비교
            name: courseName!,
            schedule: schedules.map { $0.toEntity() },
            professor: professor,
            unit: Int(schedules[0].credit)
        )
    }
    
    func toEntity(_ unit: Int) -> SectionInfo {
        .init(
            id: sectionId,
            code: courseCode!, //TODO: sectionCode랑 비교
            name: courseName!,
            schedule: schedules.map { $0.toEntity() },
            professor: professor,
            unit: unit
        )
    }
    
    func toEntity(_ unit: Int, _ code: String, _ name: String) -> SectionInfo {
        .init(
            id: sectionId,
            code: code,
            name: name,
            schedule: schedules.map { $0.toEntity() }, 
            professor: professor,
            unit: unit
        )
    }
}

extension SectioninTableResult {
    func toEntity(_ unit: Int) -> SectionInfo {
        .init(
            id: sectionId,
            code: courseCode,
            name: courseName,
            professor: professor,
            unit: unit
        )
    }
}

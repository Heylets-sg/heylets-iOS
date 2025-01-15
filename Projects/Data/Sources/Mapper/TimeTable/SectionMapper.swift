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

    
    func toEntity(_ unit: Int, _ code: String, _ name: String) -> SectionInfo {
        .init(
            id: sectionId, //TODO: sectionCode랑 비교
            code: code,
            name: name,
            schedule: schedules.map { $0.toEntity() }, 
            professor: professor,
            unit: unit
        )
    }
    
    func toEntity(_ code: String, _ name: String) -> SectionInfo {
        .init(
            id: sectionId, //TODO: sectionCode랑 비교
            code: code,
            name: name,
            schedule: schedules.map { $0.toEntity() },
            professor: professor
//            unit: unit
        )
    }
}

extension SectionInTableList{
    func toEntity() -> SectionInfo {
        .init(
            id: sectionId,
            code: courseCode,
            name: courseName,
            schedule: [],
            professor: professor,
            unit: nil
        )
    }
}

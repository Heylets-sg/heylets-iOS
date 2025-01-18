//
//  LectureMapper.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension LectureDetailResult {
    func toEntity() -> LectureInfo {
        .init(
            code: courseCode,
            name: courseName,
            unit: unit,
            department: department,
            termId: termId,
            academicYear: academicYear,
            semester: semester,
            sections: sections.map { $0.toEntity(unit, courseCode, courseName)
            }
        )
    }
}

extension LectureInfoResult {
    func toEntity() -> LectureInfo {
        .init(
            code: courseCode,
            name: courseName,
            termId: termId,
            academicYear: academicYear,
            semester: semester,
            sections: sections.map { $0.toEntity(
                Int(credit),
                courseCode,
                courseName
            ) }
        )
    }
}

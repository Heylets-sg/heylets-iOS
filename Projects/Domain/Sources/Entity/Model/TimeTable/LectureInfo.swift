//
//  LectureInfo.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct LectureInfo {
    let id: Int?
    let code: String
    let name: String
    let unit: Int?
    let department: String?
    let credit: Int?
    let courseLevel: Int?
    let termId: Int
    public let academicYear: String
    public let semester: String
    public let sections: [SectionInfo]
//    public let reviewStats: ReviewStateResult
//    public let reviews: ReviewsResult
    
    public init(
        id: Int? = nil,
        code: String,
        name: String,
        unit: Int? = nil,
        department: String? = nil,
        credit: Int? = nil,
        courseLevel: Int? = nil,
        termId: Int,
        academicYear: String,
        semester: String,
        sections: [SectionInfo]
    ) {
        self.id = id
        self.code = code
        self.name = name
        self.unit = unit
        self.department = department
        self.credit = credit
        self.courseLevel = courseLevel
        self.termId = termId
        self.academicYear = academicYear
        self.semester = semester
        self.sections = sections
    }
}

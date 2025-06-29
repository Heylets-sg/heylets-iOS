//
//  ModuleInfo.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ModuleInfo {
    let scheduleId: Int
    let courseCode: String
    let sectionCode: String
    let location: String
    let professor: String
    let classDay: String
    let startTime: String
    let endTime: String
    
    public init(
        scheduleId: Int,
        courseCode: String,
        sectionCode: String,
        location: String,
        professor: String,
        classDay: String,
        startTime: String,
        endTime: String
    ) {
        self.scheduleId = scheduleId
        self.courseCode = courseCode
        self.sectionCode = sectionCode
        self.location = location
        self.professor = professor
        self.classDay = classDay
        self.startTime = startTime
        self.endTime = endTime
    }
}

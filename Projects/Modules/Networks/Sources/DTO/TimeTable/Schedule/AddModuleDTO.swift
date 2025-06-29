//
//  LectureDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct CustomModuleRequest: Encodable {
    let title: String
    let day: String
    let startTime: String
    let endTime: String
    let location: String?
    let professor: String?
    let memo: String?
    
    public init(
        title: String,
        day: String,
        startTime: String,
        endTime: String,
        location: String?,
        professor: String?,
        memo: String?
    ) {
        self.title = title
        self.day = day
        self.startTime = startTime
        self.endTime = endTime
        self.location = location
        self.professor = professor
        self.memo = memo
    }
}

public struct AddLectureRequest: Encodable {
    let scheduleId: Int
    let memo: String
    
    public init(_ scheduleId: Int, _ memo: String) {
        self.scheduleId = scheduleId
        self.memo = memo
    }
}

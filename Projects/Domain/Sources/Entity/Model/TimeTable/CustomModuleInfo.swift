//
//  CustomModuleInfo.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

//public var id: String?
//public var code: String
//public var name: String
//public var schedule: [ScheduleInfo]
//public var professor: String
//public var unit: Int?

//public var id: Int?
//public var day: Week
//public var startHour: Int
//public var startMinute: Int
//public var endHour: Int
//public var endMinute: Int
//public var location: String


public struct CustomModuleInfo {
    public let scheduleId: Int
    public let title: String
    public let location: String
    public let professor: String
    public let classDay: String
    public let startTime: String
    public let endTime: String
    public let memo: String
    
    public init(
        scheduleId: Int,
        title: String,
        location: String,
        professor: String,
        classDay: String,
        startTime: String,
        endTime: String,
        memo: String
    ) {
        self.scheduleId = scheduleId
        self.title = title
        self.location = location
        self.professor = professor
        self.classDay = classDay
        self.startTime = startTime
        self.endTime = endTime
        self.memo = memo
    }
}

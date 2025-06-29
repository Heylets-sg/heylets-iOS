//
//  TimeTableInfo.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct TimeTableDetailInfo {
    public var tableInfo: TimeTableInfo
    public let sectionList: [SectionInfo]
    
    public init(
        tableInfo: TimeTableInfo,
        sectionList: [SectionInfo]
    ) {
        self.tableInfo = tableInfo
        self.sectionList = sectionList
    }
}

public struct TimeTableInfo {
    public var id: Int
    public var name: String
    public var semester: String
    public var academicYear: Int
    public var displayType: DisplayTypeInfo?
    
    public var timeTableName: String {
        return name == "TimeTable" ? "Set your time table name" : name
    }
    public var fullSemester: String {
        return "AY\(academicYear)/\(academicYear+1) \(semester.formatName())"
    }
    
    public init(
        id: Int,
        name: String,
        semester: String,
        academicYear: Int,
        displayType: DisplayTypeInfo? = nil
    ) {
        self.id = id
        self.name = name
        self.semester = semester
        self.academicYear = academicYear
        self.displayType = displayType
    }
}

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
    
    public var fullSemester: String {
        return "AY\(academicYear)/\(academicYear+1) \(semester.formatSemester())"
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

extension String {
    func formatSemester() -> String {
        let components = self.lowercased().split(separator: "_")
        let formatted = components.enumerated().map { index, word in
            index == 0 ? String(word.capitalized) : String(word)
        }.joined(separator: " ")
        return formatted
    }
}

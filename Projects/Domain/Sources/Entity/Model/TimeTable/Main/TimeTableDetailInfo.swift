//
//  TimeTableDetailInfo.swift
//  Domain
//
//  Created by 류희재 on 8/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

public struct TimeTableDetailInfo: Sendable {
    public var tableInfo: TimeTableInfo
    public var sectionList: [SectionInfo]
    public var timeTableCellList: [TimeTableCellInfo]
    public var weekList: [Week]
    public var hourList: [Int]
    
    public init(
        tableInfo: TimeTableInfo,
        sectionList: [SectionInfo],
        timeTableCellList: [TimeTableCellInfo],
        weekList: [Week],
        hourList: [Int]
    ) {
        self.tableInfo = tableInfo
        self.sectionList = sectionList
        self.timeTableCellList = timeTableCellList
        self.weekList = weekList
        self.hourList = hourList
    }
}

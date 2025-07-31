//
//  TimeTableData.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Domain

struct TimeTableData {
    let sectionList: [SectionInfo]
    let timeTableCells: [TimeTableCellInfo]
    let weekList: [Week]
    let hourList: [Int]
    
    init(
        _ sectionList: [SectionInfo] = [],
        _ timeTableCells: [TimeTableCellInfo] = [],
        _ weekList: [Week] = Week.weekDay,
        _ hourList: [Int] = Array(8...21)
    ) {
        self.sectionList = sectionList
        self.timeTableCells = timeTableCells
        self.weekList = weekList
        self.hourList = hourList
    }
}

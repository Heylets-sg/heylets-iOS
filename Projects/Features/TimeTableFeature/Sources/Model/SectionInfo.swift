//
//  SectionInfo.swift
//  TimeTableFeatureInterface
//
//  Created by 류희재 on 1/3/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation


struct TimeTableCellInfo {
    var id: Int
    var code: String
    var name: String
    var professor: String
    var schedule: ScheduleInfo
}

struct SectionInfo {
    var id: Int
    var code: String
    var name: String
    var professor: String
    var scheduleList: [ScheduleInfo]
}

extension Array where Element == SectionInfo {
    func createTimeTableCellList() -> [TimeTableCellInfo] {
        var timeTableCellList: [TimeTableCellInfo] = []
        
        for section in self {
            for schedule in section.scheduleList {
                let timeTableCell: TimeTableCellInfo = .init(
                    id: section.id,
                    code: section.code,
                    name: section.name,
                    professor: section.professor,
                    schedule: schedule
                )
                
                timeTableCellList.append(timeTableCell)
            }
        }
        return timeTableCellList
    }
}


extension SectionInfo {
    static var stub1: Self {
        .init(
            id: 11914,
            code: "EE3103",
            name: "ENGINEERING ELECTROMAGNETICS",
            professor: "TUT-EE04",
            scheduleList: [.stub1])
    }
    
    static var stub2: Self {
        .init(
            id: 11214,
            code: "PH1105",
            name: "OPTICS, VIBRATIONS & WAVES",
            professor: "LEC/STUDIO-LE",
            scheduleList: [.stub2_1, .stub2_2])
    }
}

//
//  ModuleInfo.swift
//  TimeTableFeatureInterface
//
//  Created by 류희재 on 1/2/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct LectureInfo: Hashable, Equatable {
    var id: Int?
    var code: String
    var name: String
    var schedule: [ScheduleInfo]
    var professor: String?
    var unit: Int?
    
    var allscheduleTime: String {
        let all = schedule.map { "\($0.day) \($0.startTime) - \($0.endTime)" }
        return all.joined(separator: ", ")
    }
    
    var location: String {
        let locationList = Dictionary(grouping: schedule) { $0.location }
        let list =  locationList.map { location, schedule in
            if schedule.allSatisfy({$0.location == schedule.first!.location}) {
                return location
            } else {
                let days = schedule.map { $0.day.rawValue }.joined(separator: ", ")
                return "\(location)(\(days))"
            }
        }
        return list.joined(separator: ", ")
    }
}

extension Array where Element == LectureInfo {
    func createTimeTableCellList() -> [TimeTableCellInfo] {
        var timeTableCellList: [TimeTableCellInfo] = []
        
        for lecture in self {
            for schedule in lecture.schedule {
                let timeTableCell: TimeTableCellInfo = .init(
                    id: lecture.id,
                    code: lecture.code,
                    name: lecture.name,
                    professor: lecture.professor ?? "To Be Announced",
                    schedule: schedule
                )
                
                timeTableCellList.append(timeTableCell)
            }
        }
        return timeTableCellList
    }
}

extension LectureInfo {
    static var search_stub: Self {
        .init(
            code: "EE3100",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2],
            professor: "TUT-EE04",
            unit: 2
        )
    }
    
    static var search_stub1: Self {
        .init(
            code: "EE3101",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2],
            professor: "TUT-EE04",
            unit: 2
        )
    }
    
    static var search_stub2: Self {
        .init(
            code: "EE3102",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2],
            professor: "TUT-EE04",
            unit: 2
        )
    }
    
    static var search_stub3: Self {
        .init(
            code: "EE3103",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2],
            professor: "TUT-EE04",
            unit: 2
        )
    }
    
    static var search_stub4: Self {
        .init(
            code: "EE3104",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2],
            professor: "TUT-EE04",
            unit: 2
        )
    }
    
    static var search_stub5: Self {
        .init(
            code: "EE3105",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2],
            professor: "TUT-EE04",
            unit: 2
        )
    }
    
    static var search_stub6: Self {
        .init(
            code: "EE3106",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2],
            professor: "TUT-EE04",
            unit: 2
        )
    }
    
    static var search_stub7: Self {
        .init(
            code: "EE3107",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2],
            professor: "TUT-EE04",
            unit: 2
        )
    }
    
    static var search_stub8: Self {
        .init(
            code: "EE3108",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2],
            professor: "TUT-EE04",
            unit: 2
        )
    }
    
    static var search_stub9: Self {
        .init(
            code: "EE3109",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub2_1, .stub2_2],
            professor: "TUT-EE04",
            unit: 2
        )
    }
}

extension LectureInfo {
    static var timetable_stub1: Self {
        .init(
            id: 11214,
            code: "PH1105",
            name: "OPTICS, VIBRATIONS & WAVES",
            schedule: [.stub2_1, .stub2_2],
            professor: "LEC/STUDIO-LE"
        )
    }
    
    static var timetable_stub2: Self {
        .init(
            id: 11914,
            code: "EE3103",
            name: "ENGINEERING ELECTROMAGNETICS",
            schedule: [.stub1],
            professor: "TUT-EE04"
        )
    }
    
    static var timetable_stub3: Self {
        .init(
            id: 11215,
            code: "PH1105(Sat)",
            name: "OPTICS, VIBRATIONS & WAVES",
            schedule: [.stub3],
            professor: "LEC/STUDIO-LE"
        )
    }
    
    static var timetable_stub4: Self {
        .init(
            id: 11216,
            code: "PH1105(Sun)",
            name: "OPTICS, VIBRATIONS & WAVES",
            schedule: [.stub4],
            professor: "LEC/STUDIO-LE"
        )
    }
}

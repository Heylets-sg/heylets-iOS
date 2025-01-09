//
//  LectureInfo.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct LectureInfo: Hashable, Equatable {
    public var id: Int?
    public var code: String
    public var name: String
    public var schedule: [ScheduleInfo]
    public var professor: String?
    public var unit: Int?
    
    public var allscheduleTime: String {
        let all = schedule.map { "\($0.day) \($0.startTime) - \($0.endTime)" }
        return all.joined(separator: ", ")
    }
    
    public var location: String {
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
    public func createTimeTableCellList() -> [TimeTableCellInfo] {
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

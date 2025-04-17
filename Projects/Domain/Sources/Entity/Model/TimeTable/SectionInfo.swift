//
//  SectionInfo.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Core
import SwiftUI

public struct SectionInfo: Hashable, Equatable {
    public var id: Int
    public var code: String?
    public var name: String
    public var schedule: [ScheduleInfo]
    public var professor: String
    public var unit: Int?
    public var memo: String?
    public var backgroundColor: String
    public var textColor: String
    
    public var isCustom: Bool
    
    public var allscheduleTime: String {
        let schedule = schedule.sorted {
            if $0.day.index == $1.day.index {
                return $0.startHour < $1.startHour
            }
            return $0.day.index < $1.day.index
        }
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
        return list.sorted().joined(separator: ", ")
    }
    
    public var timeTableCellInfo: [TimeTableCellInfo] {
        var timeTableCellList: [TimeTableCellInfo] = []
        for schedule in self.schedule {
            let timeTableCell: TimeTableCellInfo = .init(
                id: self.id,
                code: self.code ?? self.name, // customModule일 경우 이름으로
                name: self.name,
                professor: self.professor,
                unit: self.unit,
                schedule: schedule,
                backgroundColor: .init(hex: self.backgroundColor),
                textColor: .init(hex: self.textColor)
            )
            
            timeTableCellList.append(timeTableCell)
        }
        return timeTableCellList.sorted {
            if $0.schedule.day.index == $1.schedule.day.index {
                $0.schedule.startHour < $1.schedule.startHour
            } else {
                $0.schedule.day.index < $1.schedule.day.index
            }
        }
    }
    
    
    public init(
        id: Int,
        code: String? = nil,
        name: String,
        schedule: [ScheduleInfo] = [],
        professor: String,
        unit: Int?,
        memo: String? = nil,
        backgroundColor: String = "#CAD0ED",
        textColor: String = "#FFFFFF",
        isCustom: Bool = false
    ) {
        self.id = id
        self.code = code
        self.name = name
        self.schedule = schedule
        self.professor = professor
        self.unit = unit
        self.memo = memo
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.isCustom = isCustom
    }
}

extension Array where Element == SectionInfo {
    public func createTimeTableCellList() -> [TimeTableCellInfo] {
        var timeTableCellList: [TimeTableCellInfo] = []
        
        for section in self {
            for schedule in section.schedule {
                let timeTableCell: TimeTableCellInfo = .init(
                    id: section.id,
                    code: section.code ?? section.name, //customModule일 경우 이름 표시
                    name: section.name,
                    professor: section.professor,
                    unit: section.unit,
                    schedule: schedule,
                    backgroundColor: .init(hex: section.backgroundColor),
                    textColor: .init(hex: section.textColor)
                )
                
                timeTableCellList.append(timeTableCell)
            }
        }
        return timeTableCellList
    }
}

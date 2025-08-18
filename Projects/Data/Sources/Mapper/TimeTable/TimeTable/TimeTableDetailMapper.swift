//
//  TimeTableDetailMapper.swift
//  Data
//
//  Created by 류희재 on 1/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

extension TimeTableDetailInfoDTO {
    func toEntity() -> TimeTableDetailInfo {
        let sectionList = sections.map { $0.toEntity() } + customModules.map { $0.toEntity()}
        let timeTableCellList = sectionList.createTimeTableCellList()
        let weekList = configWeekList(timeTableCellList)
        let hourList = configHourList(timeTableCellList)
        
        return .init(
            tableInfo: .init(
                id: tableId,
                name: tableName,
                semester: semester,
                academicYear: academicYear,
                displayType: DisplayTypeInfo.toEntity(with: displayType)
            ),
            sectionList: sections.map { $0.toEntity() } + customModules.map { $0.toEntity()},
            timeTableCellList: timeTableCellList,
            weekList: weekList,
            hourList: hourList
        )
    }
    
    private func configHourList(
        _ timeTableCellList: [TimeTableCellInfo]
    ) -> [Int] {
        var startTime = 8
        var endTime = 21
        var hourList: [Int] = []
        
        let allTimeList = Set(
            timeTableCellList.map { $0.schedule.startHour } +
            timeTableCellList.map { $0.schedule.endHour }
        )
        
        if allTimeList.isEmpty {
            hourList = Array(startTime...endTime)
        } else {
            startTime = min(allTimeList.min()!, startTime)
            endTime = max(allTimeList.max()!, endTime)
            hourList = Array(startTime...endTime)
        }
        
        return hourList
    }
    
    private func configWeekList(
        _ timeTableCellList: [TimeTableCellInfo]
    ) -> [Week] {
        var updatedWeekList = Week.weekDay
        for cell in timeTableCellList {
            if cell.schedule.day == .Sun {
                updatedWeekList = Week.dayOfWeek
                break
            }
            if cell.schedule.day == .Sat && !updatedWeekList.contains(.Sat) {
                updatedWeekList.append(.Sat)
            }
        }
        return updatedWeekList
    }}

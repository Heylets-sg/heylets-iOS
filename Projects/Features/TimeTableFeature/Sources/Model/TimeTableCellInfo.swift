//
//  SectionInfo.swift
//  TimeTableFeatureInterface
//
//  Created by 류희재 on 1/3/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation


struct TimeTableCellInfo {
    var id: Int?
    var code: String
    var name: String
    var professor: String
    var schedule: ScheduleInfo
    
    var slot: [Int: Double] {
        var slotDict: [Int: Double] = [:]
        
        let startHour = schedule.startHour
        let startMinute = schedule.startMinute
        let endHour = schedule.endHour
        let endMinute = schedule.endMinute
        
        for hour in startHour...endHour {
            let isStartHour = (hour == startHour)
            let isEndHour = (hour == endHour)
            
            var colorRatio: Double = 1.0
            
            if isStartHour {
                let remainingMinute = 60 - startMinute
                colorRatio = Double(remainingMinute) / 60.0
            } else if isEndHour {
                let elapsedMinute = endMinute
                colorRatio = Double(elapsedMinute) / 60.0
            }
            
            colorRatio = Double(round(10 * colorRatio) / 10)
            slotDict[hour - 9] = colorRatio
        }
        return slotDict
    }
}

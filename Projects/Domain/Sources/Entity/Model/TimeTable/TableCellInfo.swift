//
//  TableCellInfo.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import SwiftUI

public struct TimeTableCellInfo: Equatable {
    public var id: Int
    public var code: String
    public var name: String
    public var professor: String
    public var unit: Int?
    public var schedule: ScheduleInfo
    public var backgrounColor: Color
    public var textColor: Color
    
    public var slot: [Int: Double] {
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
            slotDict[hour - 8] = colorRatio
        }
        return slotDict
    }
}

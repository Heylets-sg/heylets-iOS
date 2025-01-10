//
//  ScheduleInfo.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ScheduleInfo: Hashable {
    public var id: Int?
    public var day: Week
    public var startHour: Int
    public var startMinute: Int
    public var endHour: Int
    public var endMinute: Int
    public var location: String
    
    var startTime: String {
        return "\(startHour):\(startMinute)"
    }
    
    var endTime: String {
        return "\(endHour):\(endMinute)"
    }
    
    var isSaturday: Bool {
        return day == .Sat
    }
    
    var isSunday: Bool {
        return day == .Sun
    }
    
    public init(
        id: Int? = nil,
        day: Week,
        startHour: Int,
        startMinute: Int,
        endHour: Int,
        endMinute: Int,
        location: String
    ) {
        self.id = id
        self.day = day
        self.startHour = startHour
        self.startMinute = startMinute
        self.endHour = endHour
        self.endMinute = endMinute
        self.location = location
    }
}



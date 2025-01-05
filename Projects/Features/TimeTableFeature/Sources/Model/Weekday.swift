//
//  Weekday.swift
//  TimeTableFeatureInterface
//
//  Created by 류희재 on 1/3/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

enum Week: String, CaseIterable, Hashable {
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sat
    case Sun
    
    var index: Int {
        switch self {
        case .Mon:
            return 0
        case .Tue:
            return 1
        case .Wed:
            return 2
        case .Thu:
            return 3
        case .Fri:
            return 4
        case .Sat:
            return 5
        case .Sun:
            return 6
        }
    }
    
    static let weekDay: [Week] = [.Mon, .Tue, .Wed, .Thu, .Fri]
    static let dayOfWeek: [Week] = Week.allCases
}

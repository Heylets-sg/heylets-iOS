//
//  Weekday.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum Week: String, CaseIterable, Hashable, Equatable {
    case Mon
    case Tue
    case Wed
    case Thu
    case Fri
    case Sat
    case Sun
    
    public var index: Int {
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
    
    public static let weekDay: [Week] = [.Mon, .Tue, .Wed, .Thu, .Fri]
    public static let dayOfWeek: [Week] = Week.allCases
    
    public static func toWeek(from day: String) -> Week {
        switch day {
        case "MONDAY": return .Mon
        case "TUESDAY": return .Tue
        case "WEDNESDAY": return .Wed
        case "THURSDAY": return .Thu
        case "FRIDAY": return .Fri
        case "SATURDAY": return .Sat
        case "SUNDAY": return .Sun
        default: return .Mon
        }
    }
    
    public func fromWeek() -> String {
        switch self {
        case .Mon: return "MONDAY"
        case .Tue: return "TUESDAY"
        case .Wed: return "WEDNESDAY"
        case .Thu: return "THURSDAY"
        case .Fri: return "FRIDAY"
        case .Sat: return "SATURDAY"
        case .Sun: return "SUNDAY"
        }
    }
}

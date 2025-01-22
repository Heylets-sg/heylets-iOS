//
//  AddSectionError.swift
//  Domain
//
//  Created by 류희재 on 1/22/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum AddSectionError: Error {
    case inValidSemester
    case sectionNotAvailable
    case timeTableNotFound
    case sectionNotFound
    case duplicateSection
    case timeConflict
    case unknown
    
    var description: String {
        switch self {
        case .inValidSemester:
            return "The class does not belong to the current semester."
        case .sectionNotAvailable:
            return "This class cannot be registered."
        case .timeTableNotFound:
            return "The schedule cannot be found."
        case .sectionNotFound:
            return "The class cannot be found."
        case .duplicateSection:
            return "The class has already been added."
        case .timeConflict:
            return "There are overlapping classes."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}

extension AddSectionError {
    static public func error(with message: String) -> AddSectionError {
        switch message {
        case "해당 학기의 강의가 아닙니다.":
            return .inValidSemester
        case "수강 신청이 불가능한 강의입니다.":
            return .sectionNotAvailable
        case "시간표를 찾을 수 없습니다.":
            return .timeTableNotFound
        case "강의를 찾을 수 없습니다.":
            return .sectionNotFound
        case "이미 추가된 강의입니다.":
            return .duplicateSection
        case "시간이 겹치는 강의가 존재합니다.":
            return .timeConflict
        default:
            return .unknown
            
            
        }
    }
}


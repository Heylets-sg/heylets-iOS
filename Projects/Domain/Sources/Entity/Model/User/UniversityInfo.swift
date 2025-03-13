//
//  UniversityInfo.swift
//  Domain
//
//  Created by 류희재 on 3/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum UniversityInfo: String {
    case NUS
    case NTU
    case SMU
    case empty = ""
}

extension UniversityInfo {
    static public func toEntity(with university: String) -> UniversityInfo {
        switch university {
        case "NUS":
            return .NUS
        case "NTU":
            return .NTU
        case "SMU":
            return .SMU
        default:
            return .empty
        }
    }
}

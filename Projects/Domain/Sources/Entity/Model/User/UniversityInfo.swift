//
//  UniversityInfo.swift
//  Domain
//
//  Created by 류희재 on 3/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum UniversityInfo: String, Sendable {
    //싱가포르
    case NUS
    case NTU
    case SMU
    
    //말레이시아
    case UiTM
    case IIUM
    case UM
    
    case empty = ""
    
    public var nationality: NationalityInfo {
        switch self {
        case .NUS, .NTU, .SMU:
            return .Singapore
        case .UiTM, .IIUM,.UM:
            return .Malaysia
        case .empty:
            return .empty
        }
    }
    
    public var domain: String? {
        switch self {
            
        default:
            return nil
        }
    }
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
        case "UiTM":
            return .UiTM
        case "IIUM":
            return .IIUM
        case "UM":
            return .UM
        default:
            return .empty
        }
    }
}


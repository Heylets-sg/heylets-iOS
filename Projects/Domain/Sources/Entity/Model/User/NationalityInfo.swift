//
//  NationalityInfo.swift
//  Domain
//
//  Created by 류희재 on 3/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum NationalityInfo: String {
    case Malaysia
    case Singapore
    case empty = ""
    
    public var flag: String {
        switch self {
        case .Malaysia: return "🇲🇾"
        case .Singapore: return "🇸🇬"
        case .empty: return ""
        }
    }
}

extension NationalityInfo {
    static public func toEntity(with nationality: String) -> NationalityInfo {
        switch nationality {
        case "Malaysia":
            return .Malaysia
        case "Singapore":
            return .Singapore
        default:
            return .empty
        }
    }
}


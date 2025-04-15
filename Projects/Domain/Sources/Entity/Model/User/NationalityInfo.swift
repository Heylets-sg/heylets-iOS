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
    
    public var universityList: [UniversityInfo] {
        switch self {
        case .Malaysia:
            return [.UiTM, .IIUM, .UM]
        case .Singapore:
            return [.NTU, .NUS, .SMU]
        case .empty:
            return []
        }
    }
    
    public var domainList: [String] {
        switch self {
        case .Malaysia:
            return [
                "student.uitm.edu.my",
                "siswa.um.edu.my",
                "live.iium.edu.my"
//                "gmail.com",
//                "naver.com",
//                "kookmin.ac.kr"
            ]
        case .Singapore:
            return [
                "u.nus.edu",
                "e.ntu.edu.sg",
                "smu.edu.sg",
                "smu.edu.sg",
                "accountancy.smu.edu.sg",
                "computing.smu.edu.sg",
                "economics.smu.edu.sg",
                "scis.smu.edu.sg",
                "law.smu.edu.sg",
                "business.edu.sg",
                "socsc.smu.edu.sg",
                "business.smu.edu.sg",
                "gmail.com",
                "naver.com"
            ]
        case .empty:
            return []
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


//
//  FilterInfo.swift
//  Domain
//
//  Created by 류희재 on 3/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct FilterInfo {
    public var keyword: String
    public var department: String?
    public var semester: String?
    public var level: String?
    public var keywordType: String?
    
    public init(
        _ keyword: String = "",
        _ department: String? = nil,
        _ semester: String? = nil,
        _ level: String? = nil,
        _ keywordType: String? = nil
    ) {
        self.keyword = keyword
        self.department = department
        self.semester = semester
        self.level = level
        self.keywordType = keywordType
    }
    
    public func toRequestParameters() -> [String: Any] {
        var params: [String: String] = [
            "academicYear": "2024"
        ]
        
        if keyword != "" { params["keyword"] = keyword }
        if let department = department { params["department"] = department }
        if let semester = semester {
            params["semester"] = semester
        } else {
            params["semester"] = "TERM_2"
        }
        if let level = level { params["level"] = level }
        if let other = keywordType { params["keywordType"] = keywordType }
        
        return params
    }
}


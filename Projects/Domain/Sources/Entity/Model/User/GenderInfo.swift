//
//  GenderInfo.swift
//  Domain
//
//  Created by 류희재 on 3/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum Gender: String, CaseIterable {
    case men = "M"
    case women = "F"
    case others = "O"
    
    public var title: String {
        switch self {
        case .men:
            return "Men"
        case .women:
            return "Women"
        case .others:
            return "Others"
        }
    }
}

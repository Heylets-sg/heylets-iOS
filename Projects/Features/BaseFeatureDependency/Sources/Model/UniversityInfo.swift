//
//  UniversityInfo.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain
import DSKit


extension UniversityInfo {
    public var icon: Image {
        switch self {
        case .NUS: return .nus
        case .NTU: return .ntu
        case .SMU: return .smu
        default: return .icSchool
        }
    }
    
    public var badgeImage: Image {
        switch self {
        case .NUS: return .badgeNUS
        case .NTU: return .badgeNTU
        case .SMU: return .badgeSMU
        case .UiTM: return .badgeUiTM
        case .IIUM: return .badgeIIUM
        case .UM: return .badgeUM
        default: return .logo
        }
    }
}

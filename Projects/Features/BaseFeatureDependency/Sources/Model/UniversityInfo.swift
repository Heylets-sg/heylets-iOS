//
//  UniversityInfo.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import UIKit

import Domain
import DSKit


extension UniversityInfo {
    public var icon: UIImage {
        switch self {
        case .NUS:
            return .nus
        case .NTU:
            return .ntu
        case .SMU:
            return .smu
        case .empty:
            return .icSchool
        }
    }
    
    public var textColor: String {
        switch self {
        case .NUS:
            return "#DB812E"
        case .NTU:
            return "#FFFFFF"
        case .SMU:
            return "#FFFFFF"
        case .empty:
            return "#FFFFFF"
        }
    }
    
    public var backgroundColor: String {
        switch self {
        case .NUS:
            return "#1B3D76"
        case .NTU:
            return "#E01932"
        case .SMU:
            return "#1B286A"
        case .empty:
            return "#FFFFFF"
        }
    }
}

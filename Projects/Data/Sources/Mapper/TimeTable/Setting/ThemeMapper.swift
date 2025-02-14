//
//  ThemeMapper.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension ThemeDetailInfoResult {
    func toEntity() -> ThemeColorInfo {
        .init(
            name: name,
            core: colors.core,
            gradient: colors.gradient,
            dayColor: colors.dayColor,
            defaultColor: colors.defaultColor,
            specialColor: colors.specialColor ?? [String:String]()
        )
    }
}

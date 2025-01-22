//
//  SettingInfoMapper.swift
//  Data
//
//  Created by 류희재 on 1/22/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension TimeTableSettingResult {
    func toEntity() -> SettingInfo {
        .init(
            displayType: DisplayTypeInfo.toEntity(with: displayType),
            theme: theme
        )
    }
}



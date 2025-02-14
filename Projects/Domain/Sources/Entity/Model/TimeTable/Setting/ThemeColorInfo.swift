//
//  ThemeColorInfo.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ThemeColorInfo {
    let name: String
    let core: [String]
    let gradient: [String]
    let dayColor: String
    let defaultColor: String
    let specialColor: Dictionary<String, String>?
    
    public init(
        name: String,
        core: [String],
        gradient: [String],
        dayColor: String,
        defaultColor: String,
        specialColor: Dictionary<String, String>
    ) {
        self.name = name
        self.core = core
        self.gradient = gradient
        self.dayColor = dayColor
        self.defaultColor = defaultColor
        self.specialColor = specialColor
    }
}

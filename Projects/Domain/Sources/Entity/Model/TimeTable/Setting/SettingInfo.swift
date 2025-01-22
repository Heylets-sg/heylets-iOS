//
//  SettingInfo.swift
//  Domain
//
//  Created by 류희재 on 1/22/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SettingInfo {
    public let displayType: DisplayTypeInfo
    public let theme: String
    
    public init(displayType: DisplayTypeInfo, theme: String) {
        self.displayType = displayType
        self.theme = theme
    }
}

//
//  TimeTableSettingDTO.swift
//  Networks
//
//  Created by 류희재 on 1/22/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct TimeTableSettingRequest: Encodable {
    let displayType: String
    let theme: String
    
    public init(_ displayType: String, _ theme: String) {
        self.displayType = displayType
        self.theme = theme
    }
}

public struct TimeTableSettingResult: Decodable {
    public let displayType: String
    let displayTypeDescription: String
    public let theme: String
    let themeDescription: String
}

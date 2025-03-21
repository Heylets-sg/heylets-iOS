//
//  ThemePreviewDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ThemePreviewResult: Decodable {
    public let themes: [ThemeResult]
    let totalThemes: Int
    let unlockedThemes: Int
}

public struct ThemeResult: Decodable {
    public let name: String
    let description: String
    public let previewColors: [String]
    public let unlocked: Bool
}

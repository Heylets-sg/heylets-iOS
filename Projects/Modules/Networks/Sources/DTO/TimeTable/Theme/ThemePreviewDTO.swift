//
//  ThemePreviewDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ThemePreviewResult: Decodable {
    let themes: [ThemeResult]
}

public struct ThemeResult: Decodable {
    let name: String
    let description: String
    let previewColors: [String]
}

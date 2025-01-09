//
//  ThemeDetailInfoDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ThemeDetailInfoResult: Decodable {
    let name: String
    let description: String
    let colors: [ColorResult]
}

public struct ColorResult: Decodable {
    let core: [String]
    let gradient: [String]
    let dayColor: String
    let defaultColor: String
    let specialColor: [String]
}

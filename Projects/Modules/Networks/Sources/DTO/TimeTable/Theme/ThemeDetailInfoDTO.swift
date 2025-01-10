//
//  ThemeDetailInfoDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ThemeDetailInfoResult: Decodable {
    public let name: String
    let description: String
    public let colors: ColorResult
}

public struct ColorResult: Decodable {
    public let core: [String]
    public let gradient: [String]
    public let dayColor: String
    public let defaultColor: String
    public let specialColor: [String]
}

//
//  Theme.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct Theme: Hashable {
    public var colorList: [String]
    public var name: String
    public var unlocked: Bool
    
    public var themeName: String { name.formatName() }
    
    public init(
        colorList: [String],
        name: String,
        unlocked: Bool
    ) {
        self.colorList = colorList
        self.name = name
        self.unlocked = unlocked
    }
}

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
    
    public init(
        colorList: [String],
        name: String
    ) {
        self.colorList = colorList
        self.name = name
    }
}

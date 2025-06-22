//
//  CommonTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum ViewType: String, Sendable {
    case screen
    case modal
    case bottom_sheet
}

public extension AnalyticsTaxonomy {
    static func screenView(_ name: String, _ viewType: ViewType) -> AnalyticsTaxonomy {
        return AnalyticsTaxonomy(
            eventName: "screen_view",
            properties: [
                "screen_name" : name,
                "view_type": viewType
            ]
        )
    }
}

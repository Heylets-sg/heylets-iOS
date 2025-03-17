//
//  OnboardingTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public extension AnalyticsTaxonomy {
    static let clickExplore = AnalyticsTaxonomy(
        eventName: "click_explore"
    )
    
    static let clickAlreadyRegistered = AnalyticsTaxonomy(
        eventName: "click_already_registered"
    )
}

//
//  LogInTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Core

extension AnalyticsTaxonomy {
    static let clickLogin = AnalyticsTaxonomy(
        eventName: "click_login"
    )

    static let userLoggedIn = AnalyticsTaxonomy(
        eventName: "user_logged_in"
    )

    static let clickSignUp = AnalyticsTaxonomy(
        eventName: "click_sign_up"
    )
}


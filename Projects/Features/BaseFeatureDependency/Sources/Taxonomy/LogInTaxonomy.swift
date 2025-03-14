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
        category: .LogIn,
        eventName: "click_login",
        tags: ""
    )

    static let userLoggedIn = AnalyticsTaxonomy(
        category: .LogIn,
        eventName: "user_logged_in",
        tags: ""
    )

    static let clickSignUp = AnalyticsTaxonomy(
        category: .LogIn,
        eventName: "click_sign_up",
        tags: ""
    )
}


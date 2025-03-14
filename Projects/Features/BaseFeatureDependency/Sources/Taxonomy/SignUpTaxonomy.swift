//
//  SignUpTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Core

extension AnalyticsTaxonomy {
    static let clickPasteCode = AnalyticsTaxonomy(
        category: .SignUp,
        eventName: "click_paste_code",
        tags: ""
    )

    static let marketingCommunicationAgreed = AnalyticsTaxonomy(
        category: .SignUp,
        eventName: "marketing_communication_agreed",
        tags: ""
    )

    static let clickFinishSignUp = AnalyticsTaxonomy(
        category: .SignUp,
        eventName: "click_finish_sign_up",
        tags: "primary"
    )

    static let userSignedUp = AnalyticsTaxonomy(
        category: .SignUp,
        eventName: "user_signed_up",
        tags: ""
    )
}


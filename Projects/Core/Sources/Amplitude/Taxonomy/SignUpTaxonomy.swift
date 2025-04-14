//
//  SignUpTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public extension AnalyticsTaxonomy {
    static let clickPasteCode = AnalyticsTaxonomy(
        eventName: "click_paste_code"
    )

    static let marketingCommunicationAgreed = AnalyticsTaxonomy(
        eventName: "marketing_communication_agreed"
    )

    static let clickFinishSignUp = AnalyticsTaxonomy(
        eventName: "click_finish_sign_up"
    )

    static let userSignedUp = AnalyticsTaxonomy(
        eventName: "user_signed_up"
    )
    
    static func enterReferralCode(
        referralCode: String
    ) -> AnalyticsTaxonomy {
        return AnalyticsTaxonomy(
            eventName: "enter_referral_code",
            properties: [
                "referral_code": referralCode
            ]
        )
    }
    
    static func referralCodeValidated(
        referralCode: String
    ) -> AnalyticsTaxonomy {
        return AnalyticsTaxonomy(
            eventName: "referral_code_validated",
            properties: [
                "referral_code": referralCode
            ]
        )
    }
    
    static func clickSelectCountry(
        country: String
    ) -> AnalyticsTaxonomy {
        return AnalyticsTaxonomy(
            eventName: "click_select_country",
            properties: [
                "country": country
            ]
        )
    }
}


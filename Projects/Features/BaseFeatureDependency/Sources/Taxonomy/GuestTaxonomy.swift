//
//  GuestTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Core

public extension AnalyticsTaxonomy {
    static let clickStartHeylets = AnalyticsTaxonomy(
        category: .Guest,
        eventName: "click_start_heylets",
        tags: ""
    )

    static let guestModeStarted = AnalyticsTaxonomy(
        category: .Guest,
        eventName: "guest_mode_started",
        tags: ""
    )

    static let clickEditSchool = AnalyticsTaxonomy(
        category: .Guest,
        eventName: "click_edit_school",
        tags: ""
    )

    static let schoolEdited = AnalyticsTaxonomy(
        category: .Guest,
        eventName: "school_edited",
        tags: ""
    )

    static let clickGuestConfirmReject = AnalyticsTaxonomy(
        category: .Guest,
        eventName: "click_guest_confirm_reject",
        tags: ""
    )

    static let clickGuestConfirmLogin = AnalyticsTaxonomy(
        category: .Guest,
        eventName: "click_guest_confirm_login",
        tags: "primary"
    )

    static let guestConverted = AnalyticsTaxonomy(
        category: .Guest,
        eventName: "guest_converted",
        tags: "primary"
    )
}

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
        eventName: "click_start_heylets"
    )

    static let guestModeStarted = AnalyticsTaxonomy(
        eventName: "guest_mode_started"
    )

    static let clickEditSchool = AnalyticsTaxonomy(
        eventName: "click_edit_school"
    )

    static let schoolEdited = AnalyticsTaxonomy(
        eventName: "school_edited"
    )

    static let clickGuestConfirmReject = AnalyticsTaxonomy(
        eventName: "click_guest_confirm_reject"
    )

    static let clickGuestConfirmLogin = AnalyticsTaxonomy(
        eventName: "click_guest_confirm_login"
    )

    static let guestConverted = AnalyticsTaxonomy(
        eventName: "guest_converted"
    )
}

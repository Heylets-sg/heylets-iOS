//
//  TimetableSettingTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Core

extension AnalyticsTaxonomy {
    static let clickSaveTimetableSetting = AnalyticsTaxonomy(
        eventName: "click_save_timetable_setting"
    )

    static let timetableSettingSaved = AnalyticsTaxonomy(
        eventName: "timetable_setting_saved"
    )

    static let clickChangeTimetableName = AnalyticsTaxonomy(
        eventName: "click_change_timetable_name"
    )

    static let timetableNameChanged = AnalyticsTaxonomy(
        eventName: "timetable_name_changed"
    )

    static let clickCopyReferralCode = AnalyticsTaxonomy(
        eventName: "click_copy_referral_code"
    )

    static let clickShareReferralCode = AnalyticsTaxonomy(
        eventName: "click_share_referral_code"
    )
}


//
//  TimetableSettingTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public extension AnalyticsTaxonomy {
    static func clickSaveTimetableSetting(
        theme: String,
        displayType: String
    ) -> AnalyticsTaxonomy {
        return AnalyticsTaxonomy(
            eventName: "click_save_timetable_setting",
            properties: [
                "timetable_theme": theme,
                "module_info_setting": displayType
            ]
        )
    }

    static let timetableSettingSaved = AnalyticsTaxonomy(
        eventName: "timetable_setting_saved"
    )

    static func clickChangeTimetableName(
        _ timeTableName: String
    ) -> AnalyticsTaxonomy {
        return AnalyticsTaxonomy(
            eventName: "click_change_timetable_name",
            properties: [
                "timetable_name": timeTableName
            ]
        )
    }

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


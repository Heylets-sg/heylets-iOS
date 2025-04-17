//
//  MyAccountTaxonomy.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 3/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public extension AnalyticsTaxonomy {
    static let clickLogOut = AnalyticsTaxonomy(
        eventName: "click_log_out"
    )

    static let userLoggedOut = AnalyticsTaxonomy(
        eventName: "user_logged_out"
    )

    static let clickDeleteAccount = AnalyticsTaxonomy(
        eventName: "click_delete_account"
    )

    static let accountDeleted = AnalyticsTaxonomy(
        eventName: "account_deleted"
    )

    static func clickUpdateNotificationSetting(
        classReminderEnabled: Bool,
        dailyBriefing_Enabled: Bool,
        classReminderTime: String,
        dailyBriefingTime: String
    ) -> AnalyticsTaxonomy {
        return AnalyticsTaxonomy(
            eventName: "click_update_notification_setting",
            properties: [
                "class_reminder_enabled": classReminderEnabled,
                "daily_briefing_enabled": dailyBriefing_Enabled,
                "class_reminder_time": classReminderTime,
                "daily_briefing_time": dailyBriefingTime
            ]
        )
    }

    static let notificationSettingUpdated = AnalyticsTaxonomy(
        eventName: "notification_setting_updated"
    )
}


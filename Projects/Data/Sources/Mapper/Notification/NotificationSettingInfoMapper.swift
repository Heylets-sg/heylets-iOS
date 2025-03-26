//
//  NotificationSettingInfoMapper.swift
//  Data
//
//  Created by 류희재 on 3/25/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension NotificationSettingDTO {
    func toEntity() -> NotificationSettingInfo {
        .init(
            dailyBriefing: .init(
                isEnabled: dailyBriefingEnabled,
                time: dailyBriefingTime
            ),
            classNotification: .init(
                isEnabled: classNotificationEnabled,
                minutes: String(classNotificationMinutes)
            )
        )
    }
}

extension NotificationSettingInfo {
    func toDTO() -> NotificationSettingDTO {
        .init(
            dailyBriefingEnabled: dailyBriefing.isEnabled,
            classNotificationEnabled: classNotification.isEnabled,
            dailyBriefingTime: dailyBriefing.time,
            classNotificationMinutes: Int(classNotification.minutes)!
        )
    }
}





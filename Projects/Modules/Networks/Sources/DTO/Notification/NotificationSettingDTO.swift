//
//  NotificaitonSettingDTO.swift
//  Networks
//
//  Created by 류희재 on 3/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct NotificationSettingDTO: Codable {
    let dailyBriefingEnabled: Bool
    let classNotificationEnabled: Bool
    let dailyBriefingTime: String
    let classNotificationMinutes: Int
}


public struct NotificaitonSettingResult: Decodable {
    let settingId: Int
    let dailyBriefingEnabled: Bool
    let classNotificationEnabled: Bool
    let dailyBriefingTime: String
    let classNotificationMinutes: Int
    let updatedAt: String
}

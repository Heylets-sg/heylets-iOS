//
//  NotificaitonSettingDTO.swift
//  Networks
//
//  Created by 류희재 on 3/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct NotificationSettingDTO: Codable {
    public let dailyBriefingEnabled: Bool
    public let classNotificationEnabled: Bool
    public let dailyBriefingTime: String
    public let classNotificationMinutes: Int
    
    public init(
        dailyBriefingEnabled: Bool,
        classNotificationEnabled: Bool,
        dailyBriefingTime: String,
        classNotificationMinutes: Int
    ) {
        self.dailyBriefingEnabled = dailyBriefingEnabled
        self.classNotificationEnabled = classNotificationEnabled
        self.dailyBriefingTime = dailyBriefingTime
        self.classNotificationMinutes = classNotificationMinutes
    }
}


public struct NotificaitonSettingResult: Decodable {
    let settingId: Int
    let dailyBriefingEnabled: Bool
    let classNotificationEnabled: Bool
    let dailyBriefingTime: String
    let classNotificationMinutes: Int
    let updatedAt: String
}

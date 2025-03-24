//
//  NotificationSettingInfo.swift
//  Domain
//
//  Created by 류희재 on 3/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Foundation

public struct NotificationSettingInfo {
    public let dailyBriefing: DailyBriefing
    public let classNotification: ClassNotification
    
    public init(
        dailyBriefing: DailyBriefing,
        classNotification: ClassNotification
    ) {
        self.dailyBriefing = dailyBriefing
        self.classNotification = classNotification
    }
}

public struct DailyBriefing {
    public let isEnabled: Bool
    public let time: String
    
    public init(
        isEnabled: Bool,
        time: String
    ) {
        self.isEnabled = isEnabled
        self.time = time
    }
}

public struct ClassNotification {
    public let isEnabled: Bool
    public let minutes: String
    
    public init(
        isEnabled: Bool,
        minutes: String
    ) {
        self.isEnabled = isEnabled
        self.minutes = minutes
    }
}

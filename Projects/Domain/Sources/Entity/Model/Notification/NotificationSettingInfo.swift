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
    public var dailyBriefing: DailyBriefing
    public var classNotification: ClassNotification
    
    public init(
        dailyBriefing: DailyBriefing,
        classNotification: ClassNotification
    ) {
        self.dailyBriefing = dailyBriefing
        self.classNotification = classNotification
    }
}

public struct DailyBriefing {
    public var isEnabled: Bool
    public var time: String
    
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

//
//  NotificationRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 3/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol NotificationRepositoryType {
    func deleteNotificationSetting() -> AnyPublisher<Void, Error>
    func getNotificationSetting() -> AnyPublisher<NotificationSettingInfo, Error>
    func putNotificationSetting(_ settingInfo: NotificationSettingInfo) -> AnyPublisher<Void, Error>
}


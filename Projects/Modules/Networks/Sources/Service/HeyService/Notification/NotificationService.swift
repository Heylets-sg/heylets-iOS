//
//  NotificationService.swift
//  Networks
//
//  Created by 류희재 on 3/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias NotificationService = BaseService<NotificationAPI>

public protocol NotificationServiceType {
    func deleteNotificationSetting() -> NetworkVoidResponse
    func getNotificationSetting() -> NetworkDecodableResponse<NotificationSettingDTO>
    func putNotificationSetting(
        _ request: NotificationSettingDTO
    ) -> NetworkDecodableResponse<NotificaitonSettingResult>
}

extension NotificationService: NotificationServiceType {
    public func deleteNotificationSetting() -> NetworkVoidResponse {
        return requestWithNoResult(.deleteNotificationSetting)
    }
    
    public func getNotificationSetting() -> NetworkDecodableResponse<NotificationSettingDTO> {
        requestWithResult(.getNotificationSetting)
    }
    
    public func putNotificationSetting(_ request: NotificationSettingDTO) -> NetworkDecodableResponse<NotificaitonSettingResult> {
        requestWithResult(.putNotificationSettting(request))
    }
}


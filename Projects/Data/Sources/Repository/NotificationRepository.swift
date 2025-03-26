//
//  NotificationRepository.swift
//  Data
//
//  Created by 류희재 on 3/25/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct NotificationRepository: NotificationRepositoryType {
    private let service: NotificationServiceType
    
    public init(service: NotificationServiceType) {
        self.service = service
    }
    
    public func deleteNotificationSetting() -> AnyPublisher<Void, Error> {
        service.deleteNotificationSetting()
            .asVoidWithGeneralError()
    }
    
    public func getNotificationSetting() -> AnyPublisher<NotificationSettingInfo, Error> {
        service.getNotificationSetting()
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func putNotificationSetting(
        _ settingInfo: NotificationSettingInfo
    ) -> AnyPublisher<Void, Error> {
        let request = settingInfo.toDTO()
        return service.putNotificationSetting(request)
            .asVoidWithGeneralError()
    }
}

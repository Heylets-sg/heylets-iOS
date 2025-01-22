//
//  ThemeRepository.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct SettingRepository: SettingRepositoryType {
    private let service: SettingServiceType
    
    public init(service: SettingServiceType) {
        self.service = service
    }
    
    public func getThemeDetailInfo(
        _ themeName: String
    ) -> AnyPublisher<ThemeColorInfo, Error> {
        service.getThemeDetailInfo(themeName)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func getThemeList() -> AnyPublisher<[Theme], Error> {
        service.getThemeList()
            .map { $0.themes.map { $0.toEntity()} }
            .mapToGeneralError()
    }
    
    public func getTimeTableSettingInfo() -> AnyPublisher<SettingInfo, Error> {
        service.getTimeTableSettingInfo()
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func patchTimeTableSettingInfo(_ displayType: DisplayTypeInfo, _ theme: String) -> AnyPublisher<Void, Error> {
        let request: TimeTableSettingRequest = .init(displayType.rawValue, theme)
        return service.patchTimeTableSettingInfo(request)
            .asVoidWithGeneralError()
    }
}

//
//  MyPageStubUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine


final public class StubMyPageUseCase: MyPageUseCaseType {
    public var errMessage = PassthroughSubject<String, Never>()
    public var profileInfo =  PassthroughSubject<ProfileInfo, Never>()
    
    public func checkGuesetMode() -> AnyPublisher<Bool, Never> {
        Just(false).eraseToAnyPublisher()
    }
    
    public func getProfile() -> AnyPublisher<ProfileInfo, Never> {
        Just(.init(university: .NUS)).eraseToAnyPublisher()
    }
    
    public func changePassword(
        _ email: String,
        _ new: String,
        _ check: String
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func logout() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func deleteAccount(_ password: String) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func changeGuestUniversity(university: String) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func getReferralCode() -> AnyPublisher<String, Never> {
        Just("").eraseToAnyPublisher()
    }
    
    public func getNotificationSettingInfo() -> AnyPublisher<NotificationSettingInfo, Never> {
        return Just(NotificationSettingInfo(
            dailyBriefing: .init(isEnabled: true, time: ""),
            classNotification: .init(isEnabled: true, minutes: "")
            )
        )
        .eraseToAnyPublisher()
    }
    public func putNotificationSettingInfo(
        _ dailyBriefingIsEnabled: Bool,
        _ dailyBriefingTime: String,
        _ classNotificationIsEnabled: Bool,
        _ classNotificationMinute: Int
    ) -> AnyPublisher<Void, Never> {
        return Just(()).eraseToAnyPublisher()
    }
}

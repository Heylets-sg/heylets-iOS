//
//  MyPageUseCase.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

final public class MyPageUseCase: MyPageUseCaseType {
    private let userRepository: UserRepositoryType
    private let authRepository: AuthRepositoryType
    private let guestRepository: GuestRepositoryType
    private let referralRepository: ReferralRepositoryType
    private let notificationRepository: NotificationRepositoryType
    private var cancelBag = CancelBag()
    
    public init(
        userRepository: UserRepositoryType,
        authRepository: AuthRepositoryType,
        guestRepository: GuestRepositoryType,
        referralRepository: ReferralRepositoryType,
        notificationRepository: NotificationRepositoryType
    ) {
        self.userRepository = userRepository
        self.authRepository = authRepository
        self.guestRepository = guestRepository
        self.referralRepository = referralRepository
        self.notificationRepository = notificationRepository
    }
    
    public var errMessage = PassthroughSubject<String, Never>()
    
    public func checkGuesetMode() -> AnyPublisher<Bool, Never> {
        guestRepository.checkGuestMode()
    }
    
    public func getProfile() -> AnyPublisher<ProfileInfo, Never> {
        userRepository.getProfile()
            .map { $0 }
            .catch { _ in Empty() }
            .eraseToAnyPublisher()
    }
    
    public func changePassword(
        _ email: String,
        _ new: String,
        _ check: String
    ) -> AnyPublisher<Void, Never> {
        Just((email, new, check))
            .tryMap { email, new, check in
                guard new == check else { // 2. 새로운 비밀번호와 확인 비밀번호 일치 여부 확인
                    throw PasswordError.inValidCheckPassword
                }
                return new
            }
            .handleEvents(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    guard let passwordError = error as? PasswordError else { return }
                    self?.errMessage.send(passwordError.message)
                }
            })
            .flatMap {self.authRepository.resetPassword(email, $0)}
            .asVoid()
            .catch { [weak self] error in
                self?.errMessage.send("비밀번호 재설정에 실패했습니다.")
                return Just(())
            }
            .eraseToAnyPublisher()
    }
    
    public func logout() -> AnyPublisher<Void, Never> {
        authRepository.logout()
            .catch { [weak self] error in
                self?.errMessage.send("로그아웃에 실패했습니다.")
                return Empty<Void, Never>()
            }
            .eraseToAnyPublisher()
    }
    
    public func deleteAccount(_ password: String) -> AnyPublisher<Void, Never> {
        authRepository.deleteAccount(password)
            .catch { [weak self] _ in
                self?.errMessage.send("회원탈퇴에 실패했습니다")
                return Empty<Void, Never>()
            }
            .eraseToAnyPublisher()
    }
    
    public func changeGuestUniversity(university: String) -> AnyPublisher<Void, Never> {
        guestRepository.changeGuestUniversity(university: university)
            .catch { [weak self] error in
                self?.errMessage.send("대학교 변경에 실패했습니다.")
                return Empty<Void, Never>()
            }
            .eraseToAnyPublisher()
    }
    
    public func getReferralCode() -> AnyPublisher<String, Never> {
        referralRepository.getReferralCode()
            .catch { [weak self] _ in
                self?.errMessage.send("회원탈퇴에 실패했습니다")
                return Empty<String, Never>()
            }
            .eraseToAnyPublisher()
    }
    
    public func getNotificationSettingInfo() -> AnyPublisher<NotificationSettingInfo, Never>{
        notificationRepository.getNotificationSetting()
            .catch { [weak self] _ in
                self?.errMessage.send("알림설정 가져오기에 실패했습니다.")
                return Empty<NotificationSettingInfo, Never>()
            }
            .eraseToAnyPublisher()
    }
    
    public func putNotificationSettingInfo(
        _ dailyBriefingIsEnabled: Bool,
        _ dailyBriefingTime: String,
        _ classNotificationIsEnabled: Bool,
        _ classNotificationMinute: Int
    ) -> AnyPublisher<Void, Never> {
        Analytics.shared.track(.clickUpdateNotificationSetting(
            classReminderEnabled: classNotificationIsEnabled,
            dailyBriefing_Enabled: dailyBriefingIsEnabled,
            classReminderTime: "\(classNotificationMinute)",
            dailyBriefingTime: dailyBriefingTime
        ))
        let settingInfo = NotificationSettingInfo(
            dailyBriefing: .init(isEnabled: dailyBriefingIsEnabled, time: dailyBriefingTime),
            classNotification: .init(isEnabled: classNotificationIsEnabled, minutes: "\(classNotificationMinute)")
        )
        return notificationRepository.putNotificationSetting(settingInfo)
            .catch { [weak self] _ in
                self?.errMessage.send("알림설정 변경하기에 실패했습니다.")
                return Empty<Void, Never>()
            }
            .eraseToAnyPublisher()
    }
}

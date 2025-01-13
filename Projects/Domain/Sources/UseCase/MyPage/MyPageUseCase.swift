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
    private var cancelBag = CancelBag()
    
    public init(
        userRepository: UserRepositoryType,
        authRepository: AuthRepositoryType
    ) {
        self.userRepository = userRepository
        self.authRepository = authRepository
    }
    
    public var passwordFailed = PassthroughSubject<PasswordError, Never>()
    public var changePasswordFailed = PassthroughSubject<String, Never>()
    public var logoutFailed = PassthroughSubject<String, Never>()
    public var revokeUserFailed = PassthroughSubject<String, Never>()
    
    public func getProfile() -> AnyPublisher<ProfileInfo, Never> {
        userRepository.getProfile()
            .map { $0 }
            .catch { _ in Just(.init()) } // 프로필 안 불려올때
            .eraseToAnyPublisher()
    }
    
    public func changePassword(
        _ current: String,
        _ new: String,
        _ check: String
    ) -> AnyPublisher<Void, Never> {
        Just((current, new, check))
            .tryMap { current, new, check in
                guard current != new else { // 1. 현재 비밀번호와 새로운 비밀번호 비교
                    throw PasswordError.inValidCurrentPassword
                }
                guard new == check else { // 2. 새로운 비밀번호와 확인 비밀번호 일치 여부 확인
                    throw PasswordError.inValidCheckPassword
                }
                return new
            }
            .handleEvents(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    guard let passwordError = error as? PasswordError else { return }
                    self?.passwordFailed.send(passwordError)
                }
            })
            .flatMap {  newPassword in
                self.authRepository.resetPassword(newPassword)
            }
            .asVoid()
            .catch { [weak self] error in
                self?.changePasswordFailed.send("로그아웃에 실패했습니다.")
                return Just(())
            }
            .eraseToAnyPublisher()
    }
    
    public func logout() -> AnyPublisher<Void, Never> {
        authRepository.logout()
            .catch { [weak self] error in
                self?.logoutFailed.send("로그아웃에 실패했습니다.")
                return Just(())
            }
            .eraseToAnyPublisher()
    }
    
    public func deleteAccount(_ password: String) -> AnyPublisher<Void, Never> {
        return Just(()).eraseToAnyPublisher()
    }
}

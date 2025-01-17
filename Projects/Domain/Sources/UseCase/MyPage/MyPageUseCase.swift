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
                    self?.passwordFailed.send(passwordError)
                }
            })
            .flatMap {self.authRepository.resetPassword(email, $0)}
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
        authRepository.deleteAccount(password)
            .catch { [weak self] Error in
                self?.revokeUserFailed.send("회원탈퇴에 실패했습니다")
                return Just(())
            }
            .eraseToAnyPublisher()
    }
}

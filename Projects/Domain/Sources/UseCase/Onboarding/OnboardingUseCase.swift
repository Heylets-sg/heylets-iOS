//
//  OnboardingUseCase.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

final public class OnboardingUseCase: OnboardingUseCaseType {
    private let authRepository: AuthRepositoryType
    private var cancelBag = CancelBag()
    
    public init(authRepository: AuthRepositoryType) {
        self.authRepository = authRepository
    }
    
    public var userInfo: User = .empty
    
    public var errMessage = PassthroughSubject<String, Never>()
    public var requestOTPCodeFailed = PassthroughSubject<String, Never>()
    public var verifyOTPCodeFailed = PassthroughSubject<String, Never>()
    public var checkUserNameFailed = PassthroughSubject<String, Never>()
    public var signUpFailed = PassthroughSubject<String, Never>()
    public var resetPasswordFailed = PassthroughSubject<String, Never>()
    
    public func logIn(
        _ email: String,
        _ password: String
    ) -> AnyPublisher<Void, Never> {
        authRepository.logIn(email, password)
            .map { _ in }
            .catch { [weak self] error in
                self?.errMessage.send(error.description)
                return Empty<Void, Never>()
            }
            .eraseToAnyPublisher()
    }
    
    public func signUp() -> AnyPublisher<Void, Never> {
        authRepository.signUp(userInfo)
            .map { _ in }
            .catch { [weak self] _ in
                self?.signUpFailed.send("SignUp Failed")
                return Just(()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func requestEmailVerifyCode(
        _ type: VerifyCodeType,
        _ email: String
    ) -> AnyPublisher<Void, Never> {
        switch type {
        case .email:
            authRepository.requestVerifyEmail(email)
                .map { _ in }
                .catch { [weak self] _ in
                    self?.requestOTPCodeFailed.send("request OTPCode Failed (Email)")
                    return Just(()).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
            
        case .resetPassword:
            authRepository.requestResetPassword(email)
                .map { _ in }
                .catch { [weak self] _ in
                    self?.requestOTPCodeFailed.send("request OTPCode Failed (password")
                    return Just(()).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        }
    }
    
    public func verifyEmail(
        _ type: VerifyCodeType,
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Never> {
        switch type {
        case .email:
            authRepository.verifyEmail(email, otpCode)
                .map { _ in }
                .catch { [weak self] _ in
                    self?.verifyOTPCodeFailed.send("request OTPCode Failed (Email)")
                    return Just(()).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        case .resetPassword:
            authRepository.verifyResetPassword(email, otpCode)
                .map { _ in }
                .catch { [weak self] _ in
                    self?.verifyOTPCodeFailed.send("request OTPCode Failed (password")
                    return Just(()).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        }
    }
    
    public func checkUserName(
        _ userName: String
    ) -> AnyPublisher<Bool, Never> {
        authRepository.checkUserName(userName)
            .map { $0 }
            .catch { [weak self] _ in
                self?.checkUserNameFailed.send("잘못된 형식의 이름입니다")
                return Just(false).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func resetPassword(
        _ email: String,
        _ newPassword: String
    ) -> AnyPublisher<Void, Never> {
        authRepository.resetPassword(email, newPassword)
            .map { _ in }
            .catch { [weak self] _ in
                self?.resetPasswordFailed.send("resetPasswordFailed")
                return Just(()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

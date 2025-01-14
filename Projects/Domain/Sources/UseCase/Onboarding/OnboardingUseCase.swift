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
    
    public var userInfo = User(
        email: "",
        password: "",
        gender: "",
        birth: Date(),
        profile: .init(
            nickName: "",
            university: "",
            image: nil
        )
    )
    public var loginFailed = PassthroughSubject<String, Never>()
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
            .handleEvents(receiveOutput: { token in
                UserDefaultsManager.setToken(token)
            })
            .map { _ in }
            .catch { [weak self] _ in
                self?.loginFailed.send("Login Failed")
                return Just(()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func signUp() -> AnyPublisher<Void, Never> {
        authRepository.signUp(userInfo)
            .handleEvents(receiveOutput: { token in
                UserDefaultsManager.setToken(token)
            })
            .map { _ in }
            .catch { [weak self] _ in
                self?.loginFailed.send("SignUp Failed")
                return Just(()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func requestEmailVerifyCode(
        _ type: VerifyCodeType
    ) -> AnyPublisher<Void, Never> {
        switch type {
        case .email(let email):
            authRepository.requestVerifyEmail(email)
            .map { _ in }
            .catch { [weak self] _ in
                self?.requestOTPCodeFailed.send("request OTPCode Failed (Email)")
                return Just(()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
            
        case .resetPassword(let email):
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
        _ otpCode: Int
    ) -> AnyPublisher<Void, Never> {
        switch type {
        case .email(let email):
            authRepository.verifyEmail(email, otpCode)
            .map { _ in }
            .catch { [weak self] _ in
                self?.verifyOTPCodeFailed.send("request OTPCode Failed (Email)")
                return Just(()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        case .resetPassword(let email):
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
        _ newPassword: String
    ) -> AnyPublisher<Void, Never> {
        authRepository.resetPassword(
            UserDefaultsManager.getEmail(),
            newPassword
        )
        .map { _ in }
        .catch { [weak self] _ in
            self?.resetPasswordFailed.send("resetPasswordFailed")
            return Just(()).eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

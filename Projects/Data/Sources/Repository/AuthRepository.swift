//
//  AuthRepository.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct AuthRepository: AuthRepositoryType {
    public let authService: AuthServiceType
    
    public init(authService: AuthServiceType) {
        self.authService = authService
    }
    
    public func isTokenExisted() -> AnyPublisher<Bool, Never> {
        return Just(UserDefaultsManager.isTokenExist())
            .eraseToAnyPublisher()
    }
    
    public func tokenRefresh() -> AnyPublisher<Void, Error> {
        authService.refreshToken()
            .handleEvents(receiveOutput: { token in
                UserDefaultsManager.setToken(token)
            })
            .asVoidWithGeneralError()
    }
    
    public func checkUserName(
        _ name: String
    ) -> AnyPublisher<Bool, Error> {
        authService.checkUserName(name)
            .map { $0.available }
            .mapToGeneralError()
    }
    
    public func signUp(
        _ user: User
    ) -> AnyPublisher<Void, SignUpError> {
        let request: SignUpRequest = user.toDTO()
        return authService.signUp(request)
            .mapError { error in
                if let errorCode = error.isInvalidStatusCode() {
                    return SignUpError.error(with: errorCode)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func resetPassword(
        _ email: String,
        _ newPassword: String
    ) -> AnyPublisher<Auth, Error> {
        let request: ResetPasswordRequest = .init(email, newPassword)
        return authService.resetPassword(request)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func verifyResetPassword(
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Error> {
        let request: VerifyOTPCodeRequest = .init(email, otpCode)
        return authService.verifyResetPassword(request)
            .asVoidWithGeneralError()
    }
    
    public func requestResetPassword(
        _ email: String
    ) -> AnyPublisher<Void, VerificationRequestError> {
        let request: RequestOTPCodeRequest = .init(email)
        return authService.requestResetPassword(request)
            .asVoid()
            .mapError { error in
                if let errorCode = error.isInvalidStatusCode() {
                    return VerificationRequestError.error(with: errorCode)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func logout() -> AnyPublisher<Void, LogoutError> {
        authService.logout()
            .handleEvents(receiveOutput: { _ in
                UserDefaultsManager.clearToken()
            })
            .mapError { error in
                if let errorCode = error.isInvalidStatusCode() {
                    return LogoutError.error(with: errorCode)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func logIn(
        _ email: String,
        _ password: String
    ) -> AnyPublisher<Auth, LoginError> {
        let request: SignInRequest = .init(email, password)
        return authService.logIn(request)
            .handleEvents(receiveOutput: { token in
                UserDefaultsManager.setToken(token)
                UserDefaultsManager.isGuestMode = false
            })
            .map { $0.toEntity() }
            .mapError { error in
                if let errorCode = error.isInvalidStatusCode() {
                    return LoginError.error(with: errorCode)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func verifyEmail(
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Error> {
        let request: VerifyOTPCodeRequest = .init(email, otpCode)
        return authService.verifyEmail(request)
            .asVoidWithGeneralError()
    }
    
    public func requestVerifyEmail(
        _ email: String
    ) -> AnyPublisher<Void, VerificationRequestError> {
        let request: RequestOTPCodeRequest = .init(email)
        return authService.requestVerifyEmail(request)
            .asVoid()
            .mapError { error in
                if let errorCode = error.isInvalidStatusCode() {
                    return VerificationRequestError.error(with: errorCode)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func deleteAccount(
        _ password: String
    ) -> AnyPublisher<Void, Error> {
        let request: DeleteAccountRequest = .init(password)
        return authService.deleteAccount(request)
            .handleEvents(receiveOutput: { _ in
                UserDefaultsManager.clearToken()
            })
            .asVoidWithGeneralError()
    }
}

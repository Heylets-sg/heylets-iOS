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
    
    public func checkUserName(
        _ name: String
    ) -> AnyPublisher<Bool, Error> {
        authService.checkUserName(name)
            .map { $0.available }
            .mapToGeneralError()
    }
    
    public func signUp(
        _ user: User
    ) -> AnyPublisher<Void, Error> {
        let request = user.toDTO()
        return authService.signUp(request)
            .asVoidWithGeneralError()
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
    ) -> AnyPublisher<Void, Error> {
        let request: RequestOTPCodeRequest = .init(email)
        return authService.requestResetPassword(request)
            .asVoidWithGeneralError()
    }
    
    public func logout() -> AnyPublisher<Void, Error> {
        authService.logout()
            .asVoidWithGeneralError()
    }
    
    public func logIn(
        _ email: String,
        _ password: String
    ) -> AnyPublisher<Auth, Error> {
        let request: SignInRequest = .init(email, password)
        return authService.logIn(request)
            .map { $0.toEntity() }
            .mapToGeneralError()
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
    ) -> AnyPublisher<Void, Error> {
        let request: RequestOTPCodeRequest = .init(email)
        return authService.requestVerifyEmail(request)
            .asVoidWithGeneralError()
    }
    
    public func deleteAccount(
        _ password: String
    ) -> AnyPublisher<Void, Error> {
        let request: DeleteAccountRequest = .init(password)
        return authService.deleteAccount(request)
            .asVoidWithGeneralError()
    }
}

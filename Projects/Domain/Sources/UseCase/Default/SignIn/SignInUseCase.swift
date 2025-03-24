//
//  SignInUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/17/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

final public class SignInUseCase: SignInUseCaseType {
    private let authRepository: AuthRepositoryType
    private let guestRepository: GuestRepositoryType
    private var cancelBag = CancelBag()
    
    public var errMessage = PassthroughSubject<String, Never>()
    
    public init(
        authRepository: AuthRepositoryType,
        guestRepository: GuestRepositoryType
    ) {
        self.authRepository = authRepository
        self.guestRepository = guestRepository
    }
    
    public func checkAccessTokenExisted() -> AnyPublisher<Bool, Never> {
        authRepository.isTokenExisted()
    }
    
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
    
    public func verifyResetPWEmail(
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Never> {
        authRepository.verifyResetPassword(email, otpCode)
            .map { _ in }
            .catch { [weak self] _ in
                self?.errMessage.send("Incorrect security code. Check your code and try again")
                return Empty<Void, Never>()
            }
            .eraseToAnyPublisher()
    }
    
    public func requestResetPWEmailVerifyCode(
        _ email: String
    ) -> AnyPublisher<Void, Never> {
        return authRepository.requestResetPassword(email)
            .map { _ in }
            .catch { [weak self] error in
                self?.errMessage.send(error.description)
                return Empty<Void, Never>()
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
                self?.errMessage.send("resetPasswordFailed")
                return Just(()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}


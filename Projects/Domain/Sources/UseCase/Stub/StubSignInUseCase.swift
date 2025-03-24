//
//  SignInStubUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

final public class StubSignInUseCase: SignInUseCaseType {
    public func verifyResetPWEmail(_ email: String, _ otpCode: Int) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func checkAccessTokenExisted() -> AnyPublisher<Bool, Never> {
        Just(true).eraseToAnyPublisher()
    }
    
    public var errMessage = PassthroughSubject<String, Never>()
    
    public func logIn(
        _ email: String,
        _ password: String
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func requestResetPWEmailVerifyCode(
        _ email: String
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func resetPassword(
        _ email: String,
        _ newPassword: String
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}

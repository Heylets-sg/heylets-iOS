//
//  SIgnUpStubUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

final public class StubSignUpUseCase: SignUpUseCaseType {
    public var userInfo: User = .empty
    public var errMessage = PassthroughSubject<String, Never>()
    
    public func checkGuestMode() -> AnyPublisher<Bool, Never> {
        Just(true).eraseToAnyPublisher()
    }
    
    public func signUp() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func requestEmailVerifyCode(
        _ email: String
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func verifyEmail(
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func checkUserName(
        _ userName: String
    ) -> AnyPublisher<Bool, Never> {
        Just(true).eraseToAnyPublisher()
    }
    
    public func startGuestMode(
        university: UniversityInfo,
        agreements: [AgreementInfo]
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func getUniversityInfo() -> AnyPublisher<UniversityInfo, Never> {
        Just(.empty).eraseToAnyPublisher()
    }
    
    public func checkReferraalCode(_ code: String) -> AnyPublisher<Bool, Never> {
        Just(true).eraseToAnyPublisher()
    }
}

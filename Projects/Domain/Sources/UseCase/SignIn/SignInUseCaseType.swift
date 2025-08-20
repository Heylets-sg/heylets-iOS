//
//  SignInUseCaseType.swift
//  Domain
//
//  Created by 류희재 on 1/11/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Foundation
import Combine

public protocol SignInUseCaseType {
    
    var errMessage: PassthroughSubject<String, Never> { get }
    
    func checkAccessTokenExisted() -> AnyPublisher<Bool, Never>
    
    func logIn(
        _ email: String,
        _ password: String
    ) -> AnyPublisher<Void, Never>
    
    func requestResetPWEmailVerifyCode(
        _ email: String
    ) -> AnyPublisher<Void, Never>
    
    // ResetPassword
    
    func resetPassword(
        _ email: String,
        _ newPassword: String
    ) -> AnyPublisher<Void, Never>
    
    func verifyResetPWEmail(
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Never>
}

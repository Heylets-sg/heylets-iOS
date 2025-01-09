//
//  AuthRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol AuthRepositoryType {
    func checkUserName(
        _ name: String
    ) -> AnyPublisher<Bool, Error>
    
    func resetPassword(
        _ email: String,
        _ newPassword: String
    ) -> AnyPublisher<Auth, Error>
    
    func verifyResetPassword(
        _ email: String,
        _ otpCode: String
    ) -> AnyPublisher<Void, Error>
    
    func requestResetPassword(
        _ email: String
    ) -> AnyPublisher<Void, Error>
    
    func logout() -> AnyPublisher<Void, Error>
    
    func logIn(
        _ email: String,
        _ password: String
    ) -> AnyPublisher<Auth, Error>
    
    func verifyEmail(
        _ email: String,
        _ otpCode: String
    ) -> AnyPublisher<Void, Error>
    
    func requestVerifyEmail(
        _ email: String
    ) -> AnyPublisher<Void, Error>
}

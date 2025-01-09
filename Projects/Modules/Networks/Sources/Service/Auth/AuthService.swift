//
//  AuthService.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias AuthService = BaseService<AuthAPI>

public protocol AuthServiceType {
    func checkUserName(_ name: String) -> AnyPublisher<UserNameResult, HeyNetworkError>
    func resetPassword(_ request: ResetPasswordRequest) -> AnyPublisher<AuthResult, HeyNetworkError>
    func verifyResetPassword(_ request: VerifyOTPCodeRequest) -> AnyPublisher<Void, HeyNetworkError>
    func requestResetPassword(_ request: RequestOTPCodeRequest) -> AnyPublisher<RequestOTPCodeResult, HeyNetworkError>
    func logout() -> AnyPublisher<Void, HeyNetworkError>
    func login(_ request: SignInRequest) -> AnyPublisher<AuthResult, HeyNetworkError>
    func verifyEmail(_ request: VerifyOTPCodeRequest) -> AnyPublisher<Void,HeyNetworkError>
    func requestVerifyEmail(_ request: RequestOTPCodeRequest) -> AnyPublisher<RequestOTPCodeResult, HeyNetworkError>
}

extension AuthService: AuthServiceType {
    public func checkUserName(_ name: String) -> AnyPublisher<UserNameResult, HeyNetworkError> {
        requestWithResult(.checkUserName(name))
    }
    
    public func resetPassword(_ request: ResetPasswordRequest) -> AnyPublisher<AuthResult, HeyNetworkError> {
        requestWithResult(.resetPassword(request))
    }
    
    public func verifyResetPassword(_ request: VerifyOTPCodeRequest) -> AnyPublisher<Void, HeyNetworkError> {
        requestWithNoResult(.verifyResetPassword(request))
    }
    
    public func requestResetPassword(_ request: RequestOTPCodeRequest) -> AnyPublisher<RequestOTPCodeResult, HeyNetworkError> {
        requestWithResult(.requestResetPassword(request))
    }
    
    public func logout() -> AnyPublisher<Void, HeyNetworkError> {
        requestWithNoResult(.logout)
    }
    
    public func login(_ request: SignInRequest) -> AnyPublisher<AuthResult, HeyNetworkError> {
        requestWithResult(.login(request))
    }
    
    public func verifyEmail(_ request: VerifyOTPCodeRequest) -> AnyPublisher<Void,HeyNetworkError> {
        requestWithNoResult(.verifyEmail(request))
    }
    
    public func requestVerifyEmail(_ request: RequestOTPCodeRequest) -> AnyPublisher<RequestOTPCodeResult, HeyNetworkError> {
        requestWithResult(.requestVerifyEmail(request))
    }
}

//public struct StubAuthService: AuthServiceType {
//    
//}

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
    func checkUserName(
        _ name: String
    ) -> NetworkDecodableResponse<UserNameResult>
    
    func signUp(
        _ request: SignUpRequest
    ) -> NetworkDecodableResponse<AuthResult>
    
    func resetPassword(
        _ request: ResetPasswordRequest
    ) -> NetworkDecodableResponse<AuthResult>
    
    func verifyResetPassword(
        _ request: VerifyOTPCodeRequest
    ) -> NetworkVoidResponse
    
    func requestResetPassword(
        _ request: RequestOTPCodeRequest
    ) -> NetworkDecodableResponse<RequestOTPCodeResult>
    
    func logout() -> NetworkVoidResponse
    
    func logIn(
        _ request: SignInRequest
    ) -> NetworkDecodableResponse<AuthResult>
    
    func verifyEmail(
        _ request: VerifyOTPCodeRequest
    ) -> NetworkVoidResponse
    
    func requestVerifyEmail(
        _ request: RequestOTPCodeRequest
    ) -> NetworkDecodableResponse<RequestOTPCodeResult>
}

extension AuthService: AuthServiceType {
    public func checkUserName(
        _ name: String
    ) -> AnyPublisher<UserNameResult, HeyNetworkError> {
        requestWithResult(.checkUserName(name))
    }
    
    public func signUp(
        _ request: SignUpRequest
    ) -> NetworkDecodableResponse<AuthResult> {
        requestWithResult(.signUp(request))
    }
    
    public func resetPassword(
        _ request: ResetPasswordRequest
    ) -> AnyPublisher<AuthResult, HeyNetworkError> {
        requestWithResult(.resetPassword(request))
    }
    
    public func verifyResetPassword(
        _ request: VerifyOTPCodeRequest
    ) -> AnyPublisher<Void, HeyNetworkError> {
        requestWithNoResult(.verifyResetPassword(request))
    }
    
    public func requestResetPassword(
        _ request: RequestOTPCodeRequest
    ) -> AnyPublisher<RequestOTPCodeResult, HeyNetworkError> {
        requestWithResult(.requestResetPassword(request))
    }
    
    public func logout() -> AnyPublisher<Void, HeyNetworkError> {
        requestWithNoResult(.logout)
            .handleEvents(receiveOutput: { _ in
                UserDefaultsManager.clearLogout()
            })
            .eraseToAnyPublisher()
    }
    
    public func logIn(
        _ request: SignInRequest
    ) -> AnyPublisher<AuthResult, HeyNetworkError> {
        requestWithResult(.login(request))
            .handleEvents(receiveOutput: { token in
                UserDefaultsManager.setToken(token)
            })
            .eraseToAnyPublisher()
    }
    
    public func verifyEmail(
        _ request: VerifyOTPCodeRequest
    ) -> NetworkVoidResponse {
        requestWithNoResult(.verifyEmail(request))
    }
    
    public func requestVerifyEmail(
        _ request: RequestOTPCodeRequest
    ) -> AnyPublisher<RequestOTPCodeResult, HeyNetworkError> {
        requestWithResult(.requestVerifyEmail(request))
    }
}

//public struct StubAuthService: AuthServiceType {
//    
//}

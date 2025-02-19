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
    
    func refreshToken() -> NetworkDecodableResponse<AuthResult>
    
    func signUp(
        _ request: SignUpRequest
    ) -> NetworkVoidResponse
    
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
    
    func deleteAccount(
        _ request: DeleteAccountRequest
    ) -> NetworkVoidResponse
}

extension AuthService: AuthServiceType {
    public func checkUserName(
        _ name: String
    ) -> AnyPublisher<UserNameResult, HeyNetworkError> {
        requestWithResult(.checkUserName(name))
    }
    
    public func refreshToken() -> NetworkDecodableResponse<AuthResult> {
        requestWithResult(.refreshToken)
    }
    
    public func signUp(
        _ request: SignUpRequest
    ) -> NetworkVoidResponse {
        //MARK: Test용
//        requestWithNoResult(.signUp(request, UUID().uuidString))
        requestWithNoResult(.testSignUp(request, UUID().uuidString))
    }
    
    public func resetPassword(
        _ request: ResetPasswordRequest
    ) -> NetworkDecodableResponse<AuthResult> {
        requestWithResult(.resetPassword(request))
    }
    
    public func verifyResetPassword(
        _ request: VerifyOTPCodeRequest
    ) -> NetworkVoidResponse {
        requestWithNoResult(.verifyResetPassword(request))
    }
    
    public func requestResetPassword(
        _ request: RequestOTPCodeRequest
    ) -> NetworkDecodableResponse<RequestOTPCodeResult> {
        requestWithResult(.requestResetPassword(request))
    }
    
    public func logout() -> NetworkVoidResponse {
        requestWithNoResult(.logout)
            .eraseToAnyPublisher()
    }
    
    public func logIn(
        _ request: SignInRequest
    ) -> NetworkDecodableResponse<AuthResult> {
        requestWithResult(.login(request))
            .eraseToAnyPublisher()
    }
    
    public func verifyEmail(
        _ request: VerifyOTPCodeRequest
    ) -> NetworkVoidResponse {
        requestWithNoResult(.verifyEmail(request))
    }
    
    public func requestVerifyEmail(
        _ request: RequestOTPCodeRequest
    ) -> NetworkDecodableResponse<RequestOTPCodeResult> {
        requestWithResult(.requestVerifyEmail(request))
    }
    
    public func deleteAccount(
        _ request: DeleteAccountRequest
    ) -> NetworkVoidResponse {
        requestWithNoResult(.deleteAccount(request))
    }
}

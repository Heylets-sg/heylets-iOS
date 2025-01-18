//
//  SignUpUseCaseType.swift
//  Domain
//
//  Created by 류희재 on 1/11/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Foundation
import Combine

public enum VerifyCodeType: Hashable {
    case email
    case resetPassword
}

public protocol OnboardingUseCaseType {
    var userInfo: User { get set }
    
    var loginFailed: PassthroughSubject<String, Never> { get }
    var requestOTPCodeFailed: PassthroughSubject<String, Never> { get }
    var verifyOTPCodeFailed: PassthroughSubject<String, Never> { get }
    var checkUserNameFailed: PassthroughSubject<String, Never> { get }
    var signUpFailed: PassthroughSubject<String, Never> { get }
    var resetPasswordFailed: PassthroughSubject<String, Never> { get }
    
    func logIn(
        _ email: String,
        _ password: String
    ) -> AnyPublisher<Void, Never>
    
    func signUp() -> AnyPublisher<Void, Never>
    
    // 이메일 인증코드 요청 & 인증코드
    func requestEmailVerifyCode(
        _ type: VerifyCodeType,
        _ email: String
    ) -> AnyPublisher<Void, Never>
    
    func verifyEmail(
        _ type: VerifyCodeType,
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Never>
    
    // checkUserName
    func checkUserName(
        _ userName: String
    ) -> AnyPublisher<Bool, Never>
    
    // ResetPassword
    
    func resetPassword(
        _ email: String,
        _ newPassword: String
    ) -> AnyPublisher<Void, Never>
}

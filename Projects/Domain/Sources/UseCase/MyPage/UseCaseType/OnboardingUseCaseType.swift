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

public enum VerifyCodeType {
    case email
    case resetPassword
}

public protocol OnboardingUseCaseType {
    var userInfo: UserInfo { get }
    
    var verifyEmailFailed: PassthroughSubject<String, Never> { get }
    var checkUserNameFailed: PassthroughSubject<String, Never> { get }
    var signUpFailed: PassthroughSubject<String, Never> { get }
    var resetPasswordFailed: PassthroughSubject<String, Never> { get }
    
    func logIn(
        _ email: String,
        _ password: String
    ) -> AnyPublisher<Auth, Error>
    
    // 이메일 인증코드 요청 & 인증코드
    func requestEmailVerifyCode(_ type: VerifyCodeType) -> AnyPublisher<Void, Error>
    func verifyEmail(_ type: VerifyCodeType, _ email: String) -> AnyPublisher<Void, Error>
    
    // SignUp
    func checkUserName(_ userName: String) -> AnyPublisher<Void, Error>
    func makeAccount() -> AnyPublisher<Void, Error>
    
    // ResetPassword
    
    func resetPassword(_ email: String, _ newPassword: String) -> AnyPublisher<Void, Error>
    
}

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
    
    var errMessage: PassthroughSubject<String, Never> { get }
    
    func checkAccessTokenExisted() -> AnyPublisher<Bool, Never>
    
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
    
    func startGuestMode(
        university: String,
        agreements: [AgreementInfo]
    ) -> AnyPublisher<Void, Never>
    
    func verifyResetPWEmail(
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Never>
}

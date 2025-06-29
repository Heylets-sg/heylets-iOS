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
    // 자동로그인 & 토큰 존재여부
    func isTokenExisted() -> AnyPublisher<Bool, Never>
    
    // 토큰 리프레서
    func tokenRefresh() -> AnyPublisher<Void, Error>
    
    // 닉네임 중복 확인
    func checkUserName(
        _ name: String
    ) -> AnyPublisher<Bool, Error>
    
    func signUp(_ user: User) -> AnyPublisher<Void, SignUpError>
    
    // 새 비밀번호 설정
    func resetPassword(
        _ email: String,
        _ newPassword: String
    ) -> AnyPublisher<Auth, Error>
    
    // 비밀번호 재설정 인증
    func verifyResetPassword(
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Error>
    
    // 비밀번호 재설정 요청
    func requestResetPassword(
        _ email: String
    ) -> AnyPublisher<Void, VerificationRequestError>
    
    // 로그아웃
    func logout() -> AnyPublisher<Void, LogoutError>
    
    // 로그인
    func logIn(
        _ email: String,
        _ password: String
    ) -> AnyPublisher<Auth, LoginError>
    
    // 이메일 인증 확인
    func verifyEmail(
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Error>
    
    // 이메일 인증 요청
    func requestVerifyEmail(
        _ email: String
    ) -> AnyPublisher<Void, VerificationRequestError>
    
    // 회원 탈퇴
    func deleteAccount(
        _ password: String
    ) -> AnyPublisher<Void, Error>
}

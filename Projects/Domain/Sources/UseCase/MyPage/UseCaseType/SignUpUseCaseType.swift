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

public protocol SignUpUseCaseType {
    var userInfo: UserInfo { get }
    
    var verifyEmailFailed: PassthroughSubject<String, Never> { get }
    var checkUserNameFailed: PassthroughSubject<String, Never> { get }
    var signUpFailed: PassthroughSubject<String, Never> { get }
    
    func requestEmailVerifyCode() -> AnyPublisher<Void, Error>
    func verifyEmail(_ email: String) -> AnyPublisher<Void, Error>
    func checkUserName(_ userName: String) -> AnyPublisher<Void, Error>
    
    func makeAccount() -> AnyPublisher<Void, Error>
    // 회원가입
}

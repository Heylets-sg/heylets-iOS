////
////  OnboardingUseCase.swift
////  Domain
////
////  Created by 류희재 on 1/13/25.
////  Copyright © 2025 Heylets-iOS. All rights reserved.
////
//
//import Foundation
//import Combine
//
//import Core
//
//final public class OnboardingUseCase: OnboardingUseCaseType {
//    public var userInfo: UserInfo
//    
//    public var verifyEmailFailed: PassthroughSubject<String, Never>
//    
//    public var checkUserNameFailed: PassthroughSubject<String, Never>
//    
//    public var signUpFailed: PassthroughSubject<String, Never>
//    
//    public var resetPasswordFailed: PassthroughSubject<String, Never>
//    
//    public func logIn(_ email: String, _ password: String) -> AnyPublisher<Auth, any Error> {
//        <#code#>
//    }
//    
//    public func requestEmailVerifyCode(_ type: VerifyCodeType) -> AnyPublisher<Void, any Error> {
//        <#code#>
//    }
//    
//    public func verifyEmail(_ type: VerifyCodeType, _ email: String) -> AnyPublisher<Void, any Error> {
//        <#code#>
//    }
//    
//    public func checkUserName(_ userName: String) -> AnyPublisher<Void, any Error> {
//        <#code#>
//    }
//    
//    public func makeAccount() -> AnyPublisher<Void, any Error> {
//        <#code#>
//    }
//    
//    public func resetPassword(_ email: String, _ newPassword: String) -> AnyPublisher<Void, any Error> {
//        <#code#>
//    }
//    

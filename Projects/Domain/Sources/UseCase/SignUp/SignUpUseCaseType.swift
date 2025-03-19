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
    var userInfo: User { get set }
    
    var errMessage: PassthroughSubject<String, Never> { get }
    
    func checkGuestMode() -> AnyPublisher<Bool, Never>
    
    func signUp() -> AnyPublisher<Void, Never>
    
    // 이메일 인증코드 요청 & 인증코드
    func requestEmailVerifyCode(
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

    func startGuestMode(
        university: UniversityInfo,
        agreements: [AgreementInfo]
    ) -> AnyPublisher<Void, Never>
    
    func getUniversityInfo() -> AnyPublisher<UniversityInfo, Never>
}

//
//  MyPageUseCaseType.swift
//  Domain
//
//  Created by 류희재 on 1/11/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol MyPageUseCaseType {
    var passwordFailed: PassthroughSubject<PasswordError, Never> { get }
    var logoutFailed: PassthroughSubject<String, Never> { get }
    var revokeUserFailed: PassthroughSubject<String, Never> { get }
    
    func getProfile() -> AnyPublisher<ProfileInfo, Never>
    // 유저 정보 받아오기
    
    func changePassword(
        _ current: String,
        _ new: String,
        _ check: String
    ) -> AnyPublisher<Void, Never>
    
    // 현재 비번과 같은지 확인
    // new == current 같은지 확인
    // AuthRepository를 통해서 서버통신 -> Void처러
    
    func logout() -> AnyPublisher<Void, Never>
    // 로그아웃
    
    func deleteAccount(
        _ password: String
    ) -> AnyPublisher<Void, Never>
    
    // 현재 비번과 같은지 확인
    // AuthRepository 회원탈퇴 API
}

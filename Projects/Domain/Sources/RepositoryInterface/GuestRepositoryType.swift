//
//  GuestRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol GuestRepositoryType {
    // 게스트모드 체크하기
    func checkGuestMode() -> AnyPublisher<Bool, Never>
    
    // 게스트모드 학교 바꾸기
    func changeGuestUniversity(university: String) -> AnyPublisher<Void, Error>
    
    // 게스트모드 시작하기
    func startGuestMode(
        university: String,
        agreements: [AgreementInfo]
    ) -> AnyPublisher<Auth, Error>
    
    // 게스트 -> 정식회원
    func convertToMember(_ user: User) -> AnyPublisher<Void, SignUpError>
}

//
//  User.swift
//  Data
//
//  Created by 류희재 on 1/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Core
import Domain
import Networks

extension User {
    public func toDTO() -> SignUpRequest {
        .init(
            request: .init(
                nickname: nickName,
                email: email,
                password: password,
                university: university.rawValue,
                sex: gender,
                birth: birth.toString(),
                agreements: agreements.map { $0.toDTO() },
                referralCode: referralCode
            ),
            profileImg: profileImage?.jpegData(compressionQuality: 0.1)
        )
    }
    
    public func toDTO() -> GuestSignUpRequest {
        .init(
            request: .init(
                nickname: nickName,
                email: email,
                password: password,
                sex: gender,
                birth: birth.toString(),
                agreements: agreements.map { $0.toDTO() },
                referralCode: referralCode
            ),
            profileImg: profileImage?.jpegData(compressionQuality: 0.1)
        )
    }
}

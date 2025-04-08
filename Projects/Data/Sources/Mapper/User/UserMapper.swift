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
                birth: birth.toInt(),
                agreements: agreements.map { $0.toDTO() },
                code: referralCode
            ),
            profileImg: profileImage?.jpegData(compressionQuality: 0.1)
        )
    }
}

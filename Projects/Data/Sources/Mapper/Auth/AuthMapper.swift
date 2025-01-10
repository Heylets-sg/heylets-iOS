//
//  AuthMapper.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension AuthResult {
    func toEntity() -> Auth {
        .init(
            accessToken: access_token,
            refreshToken: refresh_token
        )
    }
}

//
//  RefreshTokenDTO.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct RefreshTokenRequest: Encodable {
    let refreshToken: String
    let devide_id: String
    let x_platform: String
}

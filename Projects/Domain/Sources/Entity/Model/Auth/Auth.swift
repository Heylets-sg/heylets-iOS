//
//  Auth.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct Auth {
    public let accessToken: String
    public let refreshToken: String?
//    let token_type: String
//    let expires_in: Int
    
    public init(
        accessToken: String,
        refreshToken: String?
    ) {
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
}

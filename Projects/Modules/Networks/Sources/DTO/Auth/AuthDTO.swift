//
//  AuthDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct AuthResult: Decodable, Sendable {
    public let access_token: String
    public let refresh_token: String?
    let token_type: String
    let expires_in: Int
}

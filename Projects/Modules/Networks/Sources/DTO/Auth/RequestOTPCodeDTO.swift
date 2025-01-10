//
//  EmailDTO.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct RequestOTPCodeRequest: Encodable {
    let email: String
    
    public init(_ email: String) {
        self.email = email
    }
}

public struct RequestOTPCodeResult: Decodable {
    let email: String
    let expiresIn: Int
    let nextRetryAt: String
}

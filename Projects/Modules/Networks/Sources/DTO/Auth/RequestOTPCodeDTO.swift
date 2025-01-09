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
}

struct RequestOTPCodeResult: Decodable {
    let email: String
    let expiresIn: Int
    let nextRetryAt: String
}

//
//  ReferralCodeDTO.swift
//  Networks
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ReferralCodeResult: Decodable {
    let code: String
    let referralCount: Int
}

public struct ValidateReferralCodeResult: Decodable {
    let isValid: Bool
    let code: String
    let type: String
}

public struct ValidateReferralCodeRequest: Encodable {
    let code: String
}

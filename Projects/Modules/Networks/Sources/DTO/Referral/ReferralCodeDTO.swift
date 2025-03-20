//
//  ReferralCodeDTO.swift
//  Networks
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ReferralCodeResult: Decodable {
    public let code: String
    let referralCount: Int
}

public struct ValidateReferralCodeResult: Decodable {
    public let isValid: Bool
    let code: String
    let type: String
}

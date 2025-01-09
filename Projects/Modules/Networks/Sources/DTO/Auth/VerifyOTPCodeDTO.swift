//
//  VerifyOTPCode.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct VerifyOTPCodeRequest: Encodable {
    let email: String
    let code: Int
    
    public init(_ email: String, _ code: Int) {
        self.email = email
        self.code = code
    }
}

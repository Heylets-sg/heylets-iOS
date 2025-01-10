//
//  ResetPasswordDTO.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ResetPasswordRequest: Encodable {
    let email: String
    let newPassword: String
    
    public init(
        _ email: String,
        _ newPassword: String
    ) {
        self.email = email
        self.newPassword = newPassword
    }
}

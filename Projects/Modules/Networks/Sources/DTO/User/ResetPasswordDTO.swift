//
//  ResetPasswordDTO.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct ResetPasswordRequest: Encodable {
    let email: String
    let newPassword: String
}

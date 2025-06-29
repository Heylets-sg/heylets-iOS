//
//  SignInDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SignInRequest: Encodable {
    let email: String
    let password: String
    
    public init(
        _ email: String,
        _ password: String
    ) {
        self.email = email
        self.password = password
    }
}

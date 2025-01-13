//
//  SignUpDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SignUpRequest: Encodable {
    let nickname: String
    let email: String
    let password: String
    let university: String
    let sex: String
    let birth: Int
    let profileImg: Data?
}

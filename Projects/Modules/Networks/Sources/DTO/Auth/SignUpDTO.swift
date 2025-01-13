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
    
    public init(
        nickname: String,
        email: String,
        password: String,
        university: String,
        sex: String,
        birth: Int,
        profileImg: Data?
    ) {
        self.nickname = nickname
        self.email = email
        self.password = password
        self.university = university
        self.sex = sex
        self.birth = birth
        self.profileImg = profileImg
    }
}

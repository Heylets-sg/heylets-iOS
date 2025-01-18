//
//  SignUpDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SignUpRequest: Encodable {
    let requset: RequiredRequest
    let profileImg: Data?
    
    public init(requset: RequiredRequest, profileImg: Data?) {
        self.requset = requset
        self.profileImg = profileImg
    }
}

public struct RequiredRequest: Encodable {
    let nickname: String
    let email: String
    let password: String
    let university: String
    let sex: String
    let birth: Int
    
    public init(
        nickname: String,
        email: String,
        password: String,
        university: String,
        sex: String,
        birth: Int
    ) {
        self.nickname = nickname
        self.email = email
        self.password = password
        self.university = university
        self.sex = sex
        self.birth = birth
    }
}

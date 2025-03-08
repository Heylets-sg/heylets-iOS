//
//  SignUpDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SignUpRequest: Encodable {
    let request: RequiredRequest
    let profileImg: Data?
    
    public init(request: RequiredRequest, profileImg: Data?) {
        self.request = request
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
    let agreements: [AgreementRequest]
    
    public init(
        nickname: String,
        email: String,
        password: String,
        university: String,
        sex: String,
        birth: Int,
        agreements: [AgreementRequest]
    ) {
        self.nickname = nickname
        self.email = email
        self.password = password
        self.university = university
        self.sex = sex
        self.birth = birth
        self.agreements = agreements
    }
}

public struct GuestAgreementRequest: Encodable {
    let agreements: [AgreementRequest]
    
    public init(agreements: [AgreementRequest]) {
        self.agreements = agreements
    }
}

public struct AgreementRequest: Encodable {
    let type: String
    let agreed: Bool
    let version: String
    
    public init(
        type: String,
        agreed: Bool,
        version: String
    ) {
        self.type = type
        self.agreed = agreed
        self.version = version
    }
}

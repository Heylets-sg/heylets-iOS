//
//  User.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import UIKit

public struct User: Hashable, Equatable {
    public var email: String
    public var password: String
    public var gender: String
    public var birth: Date
    public var nickName: String
    public var university: String
    public var profileImage: UIImage?
    public var agreements: [AgreementInfo]
    
    public init(
        email: String,
        password: String,
        gender: String,
        birth: Date,
        nickName: String,
        university: String,
        profileImage: UIImage? = nil,
        agreements: [AgreementInfo]
    ) {
        self.email = email
        self.password = password
        self.gender = gender
        self.birth = birth
        self.nickName = nickName
        self.university = university
        self.profileImage = profileImage
        self.agreements = agreements
    }
}

public struct ProfileInfo: Hashable {
    public var nickName: String
    public var university: String
    public var imageURL: String?
    
    public init(
        nickName: String = "",
        university: String = "",
        imageURL: String? = nil
    ) {
        self.nickName = nickName
        self.university = university
        self.imageURL = imageURL
    }
}

public struct AgreementInfo: Hashable {
    public var type: String
    public var agreed: Bool
    public var version: String
    
    public init(
        _ type: String,
        _ agreed: Bool,
        _ version: String
    ) {
        self.type = type
        self.agreed = agreed
        self.version = version
    }
}

extension AgreementInfo {
    static public var termsOfService: Self { .init("TERMS_OF_SERVICE", true, "1.0.0") }
    static public var privacyPolicy: Self { .init("PRIVACY_POLICY", true, "1.0.0") }
    static public var marketing: Self { .init("MARKETING", true, "1.0.0") }
    
    static public var agreementList: [AgreementInfo] = [
        .termsOfService,
        .privacyPolicy
    ]
}

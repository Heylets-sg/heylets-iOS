//
//  User.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import UIKit

public struct User: Hashable {
    public var email: String
    public var password: String
    public var gender: String
    public var birth: Date
    public var nickName: String
    public var university: String
    public var profileImage: UIImage?
    
    public init(
        email: String,
        password: String,
        gender: String,
        birth: Date,
        nickName: String,
        university: String,
        profileImage: UIImage? = nil
    ) {
        self.email = email
        self.password = password
        self.gender = gender
        self.birth = birth
        self.nickName = nickName
        self.university = university
        self.profileImage = profileImage
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
}

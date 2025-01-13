//
//  User.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import UIKit

public struct UserInfo: Hashable {
    public var email: String
    public var password: String
    public var gender: String
    public var birth: Date
    public var profile: ProfileInfo
    
    public init(
        email: String,
        password: String,
        gender: String,
        birth: Date,
        profile: ProfileInfo
    ) {
        self.email = email
        self.password = password
        self.gender = gender
        self.birth = birth
        self.profile = profile
    }
}

public struct ProfileInfo: Hashable {
    public var nickName: String
    public var university: String
    public var image: UIImage?
    
    public init(
        nickName: String = "",
        university: String = "",
        image: UIImage? = nil
    ) {
        self.nickName = nickName
        self.university = university
        self.image = image
    }
}

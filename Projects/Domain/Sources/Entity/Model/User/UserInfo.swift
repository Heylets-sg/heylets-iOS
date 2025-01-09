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
    public var nickName: String
    public var email: String
    public var password: String
    public var university: String
    public var gender: String
    public var birth: Date
    public var profileImage: UIImage?
    
    public init(
        nickName: String,
        email: String,
        password: String,
        university: String,
        gender: String,
        birth: Date,
        profileImage: UIImage? = nil
    ) {
        self.nickName = nickName
        self.email = email
        self.password = password
        self.university = university
        self.gender = gender
        self.birth = birth
        self.profileImage = profileImage
    }
}

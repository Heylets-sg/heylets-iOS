//
//  User_Stub.swift
//  Domain
//
//  Created by 류희재 on 1/15/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

extension User {
    static public var empty: Self {
        .init(
            email: "",
            password: "",
            gender: "",
            birth: Date(),
            nickName: "",
            university: "",
            profileImage: nil
        )
    }
}

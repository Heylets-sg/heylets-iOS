//
//  User_Stub.swift
//  Domain
//
//  Created by 류희재 on 1/15/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import DSKit

extension User {
    static public var stub: Self {
        .init(
            email: "fbgmlwo123@naver.com",
            password: "fbgmlwo1072!",
            gender: "M",
            birth: Date(),
            profile: .init(
                nickName: "hidi",
                university: "KMU",
                image: .icBack
            )
        )
    }
}

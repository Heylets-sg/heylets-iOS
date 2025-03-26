//
//  ProfileInfo_Stub.swift
//  Domain
//
//  Created by 류희재 on 2/4/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

extension ProfileInfo {
    static public var stub: Self {
        .init(
            nickName: "류희재",
            university: .NUS
        )
    }
    
    static public var empty: Self {
        .init(
            nickName: "",
            university: .empty
        )
    }
}

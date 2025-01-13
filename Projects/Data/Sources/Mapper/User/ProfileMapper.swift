//
//  ProfileMapper.swift
//  Data
//
//  Created by 류희재 on 1/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension MyProfileResult {
    func toEntity() -> ProfileInfo {
        .init(
            nickName: nickname,
            university: university
//            image: Image(""profileImageUrl -> 킹피셔 다운 이후
        )
    }
}

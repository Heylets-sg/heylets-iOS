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
import UIKit

extension MyProfileResult {
    func toEntity() -> ProfileInfo {
        .init(
            nickName: nickname,
            university: university,
            imageURL: profileImageUrl
        )
    }
}

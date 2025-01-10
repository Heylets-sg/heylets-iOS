//
//  UserNameDTO.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct UserNameResult: Decodable {
    public let available: Bool
    let message: String
}

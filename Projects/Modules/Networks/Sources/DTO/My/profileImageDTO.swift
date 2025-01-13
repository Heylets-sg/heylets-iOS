//
//  profileImageDTO.swift
//  Networks
//
//  Created by 류희재 on 1/11/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct profileImgResult: Decodable {
    let imageUrl: String
}

public struct profileImgRequest: Encodable {
    let image: Data
}

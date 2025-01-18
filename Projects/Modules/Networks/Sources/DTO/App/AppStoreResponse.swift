//
//  AppStoreResponse.swift
//  Networks
//
//  Created by 류희재 on 1/14/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct AppStoreResponse: Decodable {
    let results: [AppStoreResultResponse]
}

struct AppStoreResultResponse: Decodable {
    let version: String
}

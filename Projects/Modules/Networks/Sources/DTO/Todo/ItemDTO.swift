//
//  ItemDTO.swift
//  Networks
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct ItemRequest: Encodable {
    let content: String
    
    public init(_ content: String) {
        self.content = content
    }
}

public struct ItemResult: Decodable {
    public let itemId: Int
    public let content: String
    public let completed: Bool
    let completedAt: String?
    let displayOrder: Int
}

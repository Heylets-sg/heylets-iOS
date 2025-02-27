//
//  Group.swift
//  Domain
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct TodoGroup: Hashable {
    public let id: Int
    public let name: String
    public let items: [TodoItem]
}

public struct TodoItem: Hashable {
    public let id: Int
    public let content: String
    public let completed: Bool
}

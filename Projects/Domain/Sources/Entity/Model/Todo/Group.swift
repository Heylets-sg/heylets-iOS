//
//  Group.swift
//  Domain
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum GroupType: String {
    case `default`
    case custom
    
    public static func toGroupType(from group: String) -> GroupType {
        return group == "CUSTOM" ? .custom : .default
    }
}

public struct TodoGroup: Hashable {
    public let id: Int
    public let type: GroupType
    public let name: String
    public var items: [TodoItem]
    
    public init(
        id: Int,
        type: GroupType,
        name: String,
        items: [TodoItem]
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.items = items
    }
}

public struct TodoItem: Hashable {
    public let id: Int
    public let content: String
    public let completed: Bool
    
    public init(
        id: Int,
        content: String,
        completed: Bool
    ) {
        self.id = id
        self.content = content
        self.completed = completed
    }
}

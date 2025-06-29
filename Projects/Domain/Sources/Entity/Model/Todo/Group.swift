//
//  Group.swift
//  Domain
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum GroupType: String, Sendable {
    case `default`
    case custom
    
    public static func toGroupType(from group: String) -> GroupType {
        return group == "CUSTOM" ? .custom : .default
    }
}

public struct TodoGroup: Hashable, Sendable {
    public let id: Int
    public let type: GroupType
    public let name: String
    public var items: [TodoItem]
    public var isAddItemMode: Bool
    
    public init(
        id: Int,
        type: GroupType,
        name: String,
        items: [TodoItem],
        isAddItemMode: Bool = false
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.items = items
        self.isAddItemMode = isAddItemMode
    }
}

public struct TodoItem: Hashable, Sendable {
    public let id: Int
    public let content: String
    public let completed: Bool
    public var isEditing: Bool
    
    public init(
        id: Int,
        content: String,
        completed: Bool,
        isEditing: Bool = false
    ) {
        self.id = id
        self.content = content
        self.completed = completed
        self.isEditing = isEditing
    }
}

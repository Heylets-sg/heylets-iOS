//
//  GroupMapper.swift
//  Data
//
//  Created by 류희재 on 2/28/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Networks
import Domain

extension SectionGroupResult {
    func toEntity() -> TodoGroup {
        .init(
            id: groupId,
            type: GroupType.toGroupType(from: "DEFAULT"),
            name: groupName,
            items: items.map { $0.toEntity() }
        )
    }
}

extension CustomGroupResult {
    func toEntity() -> TodoGroup {
        .init(
            id: groupId,
            type: GroupType.toGroupType(from: type),
            name: groupName,
            items: items.map { $0.toEntity() }
        )
    }
}


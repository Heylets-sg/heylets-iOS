//
//  ItemMapper.swift
//  Data
//
//  Created by 류희재 on 2/28/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Networks
import Domain

extension ItemResult {
    func toEntity() -> TodoItem {
        .init(
            id: itemId,
            content: content,
            completed: completed
        )
    }
}

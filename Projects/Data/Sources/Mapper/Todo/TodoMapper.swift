//
//  TodoMapper.swift
//  Data
//
//  Created by 류희재 on 2/28/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Networks
import Domain

extension TodoResult {
    func toEntity() -> [TodoGroup] {
        return sectionGroups.map { $0.toEntity() } + customGroups.map { $0.toEntity() }
    }
}

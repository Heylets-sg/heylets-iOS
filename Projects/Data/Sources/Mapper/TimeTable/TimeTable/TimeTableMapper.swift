//
//  TimeTableMapper.swift
//  Data
//
//  Created by 류희재 on 1/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension TimeTableInfoResult {
    func toEntity() -> TimeTableInfo {
        .init(
            id: tableId,
            name: tableName,
            semester: semester,
            academicYear: academicYear
        )
    }
}

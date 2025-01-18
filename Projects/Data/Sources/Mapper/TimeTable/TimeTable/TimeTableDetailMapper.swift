//
//  TimeTableDetailMapper.swift
//  Data
//
//  Created by 류희재 on 1/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

extension TimeTableDetailInfoDTO {
    func toEntity() -> TimeTableDetailInfo {
        .init(
            tableInfo: .init(
                id: tableId,
                name: tableName,
                semester: semester,
                academicYear: academicYear
            ),
            sectionList: sections.map { $0.toEntity() } + customModules.map { $0.toEntity()}
        )
    }
}

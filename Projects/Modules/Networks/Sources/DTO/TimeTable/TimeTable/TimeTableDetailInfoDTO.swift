//
//  TimeTableDetailInfoDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct TimeTableDetailInfoDTO: Decodable {
    let tableId: Int
    let tableName: String
    let semester: String
    let acadmicYear: Int
    let isFavorite: Bool
    let status: String
    let color: String
    let displayType: String
    let sections: [SectionResult]
    let customMudles: [CustomModuleDTO]
}

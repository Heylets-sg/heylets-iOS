//
//  TimeTableDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct TimeTableListResult: Decodable {
    let tables: [TimeTableInfoResult]
}

public struct TimeTableEditNameRequest: Encodable {
    let tableName: String
}

public struct AddTimeTableRequest: Encodable {
    let tableName: String
    let semester: String
    let academicYear: Int
}

public struct TimeTableInfoResult: Decodable {
    let tableId: Int
    let tableName: String
    let semester: String
    let acadmicYear: Int
    let isFavorite: Bool
    let status: String
    let sections: [SectionResult]
}

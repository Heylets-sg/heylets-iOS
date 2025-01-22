//
//  TimeTableDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct TimeTableListResult: Decodable {
    public let tables: [TimeTableInfoResult]
}

public struct TimeTableInfoResult: Decodable {
    public let tableId: Int
    public let tableName: String
    public let semester: String
    public let academicYear: Int
    let isFavorite: Bool
    let status: String
    let sections: [SectioninTableListResult]
}

public struct TimeTableEditNameRequest: Encodable {
    let tableName: String
    
    public init(_ tableName: String) {
        self.tableName = tableName
    }
}

public struct AddTimeTableRequest: Encodable {
    let tableName: String
    let semester: String
    let academicYear: Int
    
    public init(
        _ tableName: String,
        _ semester: String,
        _ academicYear: Int
    ) {
        self.tableName = tableName
        self.semester = semester
        self.academicYear = academicYear
    }
}

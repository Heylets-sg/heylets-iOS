//
//  TimeTableDetailInfoDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct TimeTableDetailInfoDTO: Decodable {
    public let tableId: Int
    public let tableName: String
    public let semester: String
    public let academicYear: Int
    let isFavorite: Bool
    let status: String
    public  let displayType: String
    public let sections: [SectioninTableResult]
    public let customModules: [CustomModuleResult]
}

//
//  SectionDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SectionResult: Decodable {
    public let sectionId: Int
    public let sectionCode: String
    public let professor: String
    public let status: String
    public let schedules: [SchedulesResult]
}

public struct SectionInTableList: Decodable {
    public let sectionId: Int
    public let courseName: String
    public let courseCode: String
    public let professor: String
    public let status: String
}

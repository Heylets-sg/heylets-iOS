//
//  SectionInfoResult.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SectionInfoResult: Decodable {
    public let sectionId: Int
    public let courseCode: String
    public let courseName: String
    public let credit: Int?
    public let professor: String
    public let sectionStatus: String
    public let schedules: [SchedulesResult]
}

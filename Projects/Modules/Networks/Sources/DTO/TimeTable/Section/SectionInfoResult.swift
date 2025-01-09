//
//  SectionInfoResult.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SectionInfoResult: Decodable {
    let sectionId: Int
    let courseCode: String
    let courseName: String
    let credit: Int
    let professor: String
    let sectionStatus: String
    let schedules: [SchedulesResult]
}

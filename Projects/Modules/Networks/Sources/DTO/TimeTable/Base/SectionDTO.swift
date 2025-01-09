//
//  SectionDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct SectionResult: Decodable {
    let sectionCode: String
    let professor: String
    let schedules: [SchedulesResult]
}

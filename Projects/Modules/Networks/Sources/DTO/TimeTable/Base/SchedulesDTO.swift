//
//  ScheduleDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct SchedulesResult: Decodable {
    let scheduleId: Int?
    let classDay: String
    let startTime: String
    let endTime: String
    let location: String
    let professor: String?
}

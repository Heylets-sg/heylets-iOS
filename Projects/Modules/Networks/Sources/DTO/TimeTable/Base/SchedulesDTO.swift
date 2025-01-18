//
//  ScheduleDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SchedulesResult: Decodable {
    public let scheduleId: Int?
    public let location: String
    public let professor: String?
    public let classDay: String
    public let startTime: String
    public let endTime: String
}

//
//  LectureDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct CustomModuleDTO: Codable {
    let scheduleId: Int?
    let title: String
    let location: String
    let professor: String
    let day: String
    let startTime: String
    let endTime: String
    let memo: String
}

public struct AddLectureRequest: Encodable {
    let scheduleId: Int
    let memo: String
}


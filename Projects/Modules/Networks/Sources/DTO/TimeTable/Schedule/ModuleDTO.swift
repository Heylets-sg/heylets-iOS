//
//  ModuleDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

// custom: title, memo / 정규:  coursecode, sectioncode
public struct ModuleResult: Decodable {
    let scheduleId: Int
    let title: String?
    let courseCode: String?
    let sectionCode: String?
    let location: String
    let professor: String
    let classDay: String
    let startTime: String
    let endTime: String
    let memo: String?
}

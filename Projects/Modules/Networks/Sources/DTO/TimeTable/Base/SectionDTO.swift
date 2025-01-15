//
//  SectionDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct SectionResult: Decodable {
    public let sectionCode: String
    public let professor: String
    public let courseCode: String?
    public let courseName: String?
    public let schedules: [SchedulesResult]
    
    //강의 조회시
    public let sectionID: Int?
    public let status: String?
    
    enum CodingKeys: String, CodingKey {
        case sectionID = "sectionId"
        case sectionCode, professor, courseCode, courseName, status, schedules
    }
}

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
    public let sectionCode: String?
    public let professor: String
    public let status: String?
    public let schedules: [SchedulesResult]
    
    public let courseCode: String?
    public let courseName: String?
//    public let displayStyle: DisplayStyleResult
    
    
    //강의 조회시
    
}

public struct SectioninTableResult: Decodable {
    public let sectionId: Int
    public let courseCode: String
    public let courseName: String
    public let professor: String
    public let sectionStatus: String
    public let displayStyle: DisplayStyleResult
    public let schedules: [SchedulesinTableResult]
}

public struct SectioninTableListResult: Decodable {
    public let sectionId: Int
    public let courseCode: String
    public let courseName: String
    public let professor: String
    public let status: String
}



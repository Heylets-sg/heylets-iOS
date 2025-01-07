//
//  TimeTableInfo.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/6/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct TimeTableInfo {
    var id: Int
    var name: String
    var semester: String
    var academicYear: Int
    //    var isFavorite: Bool
    //    var status: "DRAFT"
    //    var color: "#123456"
    //    "displayType": "MODULE_CODE_CLASSROOM"
    
    var fullSemester: String {
        return "AY\(academicYear)/\(academicYear+1) \(semester)"
    }
}

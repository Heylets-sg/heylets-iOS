//
//  AcademicDTO.swift
//  Networks
//
//  Created by 류희재 on 1/11/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct AcademicDTO: Codable {
    let matriculationYear: Int
    let academicYear: Int
    let studentId: String
    
    public init(
        _ matriculationYear: Int,
        _ academicYear: Int,
        _ studentId: String
    ) {
        self.matriculationYear = matriculationYear
        self.academicYear = academicYear
        self.studentId = studentId
    }
}

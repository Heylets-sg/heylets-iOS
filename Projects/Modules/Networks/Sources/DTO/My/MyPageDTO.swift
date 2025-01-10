//
//  MyPageDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct EditNameRequest: Encodable {
    let nickName: String
    
    public init(_ nickName: String) {
        self.nickName = nickName
    }
}

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

public struct profileImgResult: Decodable {
    let imageUrl: String
}

public struct MyProfileResult: Decodable {
    public let nickname: String
    public let university: String
    public let profileImageUrl: String
}

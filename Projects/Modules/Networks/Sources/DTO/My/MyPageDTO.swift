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
}

public struct AcademicDTO: Codable {
    let matriculationYear: Int
    let academicYear: Int
    let studentId: String
}

public struct profileImgResult: Decodable {
    let imageUrl: String
}

public struct MyProfileResult: Decodable {
    let nickname: String
    let university: String
    let profileImageUrl: String
}

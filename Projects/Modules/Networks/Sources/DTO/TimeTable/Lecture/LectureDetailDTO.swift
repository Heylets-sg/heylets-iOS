//
//  LectureDetailDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct LectureDetailResult: Decodable {
    public let courseCode: String
    public let courseName: String
    public let unit: Int
    public let department: String
    public let termId: Int
    public let academicYear: String
    public let semester: String
    public let sections: [SectionResult]
    let reviewStats: ReviewStateResult
    let reviews: ReviewsResult
}

struct ReviewStateResult: Decodable {
    let totalRevies: Int
    let averageRating: Double
}

struct ReviewsResult: Decodable {
    let content: [ReviewContentResult]
    let totalPages, totalElements, currentPage, size: Int
}

struct ReviewContentResult: Decodable {
    let reviewId: Int
    let semester, content: String
    let rating: Int
    let createdAt: String
}

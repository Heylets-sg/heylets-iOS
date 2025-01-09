//
//  LectureDetailDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct LectureDetailResult: Decodable {
    let courseCode: String
    let courseName: String
    let unit: Int
    let department: String
    let termId: Int
    let academicYear: String
    let semester: String
    let sections: [SectionResult]
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

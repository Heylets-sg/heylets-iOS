//
//  LectureListDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct LectureListResult: Decodable {
    public let content: [LectureInfoResult]
    let pageable: PageableResult
    let last: Bool
    let totalPages, totalElements, size, number: Int
    let sort: SortResult
    let first: Bool
    let numberOfElements: Int
    let empty: Bool
}

public struct LectureInfoResult: Decodable {
    public let lectureId: Int
    public let courseCode, courseName: String
    public let sections: [SectionResult]
    public let credit: Double
    public let courseLevel: Int?
    public let termId: Int
    public let academicYear: String
    public let semester: String
    public let keywordScore: Double
//    requiresModuleSelection
}

// MARK: - Pageable
struct PageableResult: Decodable {
    let pageNumber, pageSize: Int
    let sort: SortResult
    let offset: Int
    let paged, unpaged: Bool
}

// MARK: - Sort
struct SortResult: Decodable {
    let empty, sorted, unsorted: Bool
}

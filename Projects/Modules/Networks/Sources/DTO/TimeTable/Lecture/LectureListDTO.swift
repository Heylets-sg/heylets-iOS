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
    let totalElements, totalPages: Int
    let sort: SortResult
    let first: Bool
    let size, number, numberOfElements: Int
    let empty: Bool
}

public struct LectureInfoResult: Decodable {
    public let lectureId: Int
    public let courseCode: String
    public let courseName: String
    public let sections: [SectionResult]
    public let credit: Int
    public let courseLevel: Int?
    public let termId: Int
    public let academicYear: String
    public let semester: String
    public let keywordScore: Int
}

struct PageableResult: Decodable {
    let pageNumber, pageSize: Int
    let sort: SortResult
    let offset: Int
    let paged, unpaged: Bool
}

struct SortResult: Decodable {
    let empty, unsorted, sorted: Bool
}

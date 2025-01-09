//
//  LectureListDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

struct LectureListResult: Decodable {
    let content: LectureInfoResult
    let pageable: PageableResult
    let last: Bool
    let totalElements, totalPages: Int
    let sort: SortResult
    let first: Bool
    let size, number, numberOfElements: Int
    let empty: Bool
}

struct LectureInfoResult: Decodable {
    let lectureId: Int
    let courseCode: String
    let courseName: String
    let sections: [SectionResult]
    let credit: Int
    let courseLevel: Int?
    let termId: Int
    let academicYear: String
    let semester: String
    let keywordScore: Int
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

//
//  LectureRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol LectureRepositoryType {
    func getLectureDetailInfo(
        _ lectureId: Int
    ) -> AnyPublisher<LectureInfo, Error>
    
    func getLectureList() -> AnyPublisher<[SectionInfo], Error>
    
    func getLectureListWithKeyword(
        _ keyword: String
    ) -> AnyPublisher<[SectionInfo], Error>
    
    func getLectureDepartment(
        _ university: String
    ) -> AnyPublisher<[String], Error>
    
//    func getKeyword() -> AnyPublisher<
}

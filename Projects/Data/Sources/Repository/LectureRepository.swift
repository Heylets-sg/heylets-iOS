//
//  LectureRepository.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct LectureRepository: LectureRepositoryType {
    private let service: LectureServiceType
    
    public init(service: LectureServiceType) {
        self.service = service
    }
    
    public func getLectureDetailInfo(
        _ lectureId: Int
    ) -> AnyPublisher<LectureInfo, Error> {
        service.getLectureDetailInfo(lectureId)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func getLectureList() -> AnyPublisher<[LectureInfo], Error> {
        service.getLectureList()
            .map { $0.content.map {$0.toEntity()} }
            .mapToGeneralError()
    }
    
    public func getLectureListWithKeyword(_ keyword: String) -> AnyPublisher<[LectureInfo], Error> {
        service.getLectureListWithKeyword(keyword)
            .map { $0.content.map {$0.toEntity()} }
            .mapToGeneralError()
    }
}

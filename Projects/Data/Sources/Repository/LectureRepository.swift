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
    
    public func getLectureList(
        _ filterInfo: FilterInfo
    ) -> AnyPublisher<[SectionInfo], Error> {
        let params = filterInfo.toRequestParameters()
        return service.getLectureList(params)
            .map { $0.content.flatMap { $0.toEntity().sections } }
            .mapToGeneralError()
    }
    
    public func getLectureDepartment(
        _ university: String
    ) -> AnyPublisher<[String], Error> {
        service.getLectureDepartment(university)
            .map { $0.departments }
            .mapToGeneralError()
    }
}

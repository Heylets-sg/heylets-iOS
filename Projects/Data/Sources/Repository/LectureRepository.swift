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
    private let cacheManager: LectureCacheManager
    
    public init(
        service: LectureServiceType,
        cacheManager: LectureCacheManager
    ) {
        self.service = service
        self.cacheManager = cacheManager
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
        let cacheKey = cacheManager.makeLecturesCacheKey(department: filterInfo.department)
        
        return cacheManager.getCachedLectures(for: cacheKey, page: filterInfo.page)
            .flatMap { [service, cacheManager] cachedInfo -> AnyPublisher<[SectionInfo], Error> in
                if let cachedInfo = cachedInfo {
                    print("✅ Cache HIT for cacheKey: \(cacheKey) page: 0 ~ \(filterInfo.page)")
                    return Just(cachedInfo)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                } else {
                    print("❌ Cache MISS for cacheKey: \(cacheKey) - Fetching from server")
                    let params = filterInfo.toRequestParameters()
                    return service.getLectureList(params)
                        .map { $0.content.flatMap { $0.toEntity().sections } }
                        .handleEvents(receiveOutput: {
                            cacheManager.appendLectures($0, for: cacheKey, page: filterInfo.page)
                        })
                        .mapToGeneralError()
                }
            }
            .eraseToAnyPublisher()
        
        
        
    }
    
    public func getLectureDepartment(
        _ university: String
    ) -> AnyPublisher<[String], Error> {
        service.getLectureDepartment(university)
            .map { $0.departments }
            .mapToGeneralError()
    }
}

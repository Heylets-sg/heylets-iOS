//
//  SectionRepository.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct SectionRepository: SectionRepositoryType {
    private let service: SectionServiceType
    private let cacheManager: TimeTableCacheManagerType
    
    public init(
        service: SectionServiceType,
        cacheManager: TimeTableCacheManagerType
    ) {
        self.service = service
        self.cacheManager = cacheManager
    }
    
    public func deleteAllSection(
        _ tableId: Int
    ) -> AnyPublisher<Void, DeleteAllSectionError> {
        service.deleteAllSection(tableId)
            .asVoid()
            .handleEvents(receiveOutput: {
                cacheManager.deleteAllSection(for: tableId)
            })
            .mapError { error in
                if let statusCode = error.isInvalidStatusCode() {
                    return DeleteAllSectionError.error(with: statusCode)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func deleteSection(
        _ tableId: Int,
        _ sectionId: Int
    ) -> AnyPublisher<Void, Error> {
        service.deleteSection(tableId, sectionId)
            .handleEvents(receiveOutput: {
                cacheManager.deleteSection(for: tableId, sectionId)
            })
            .asVoidWithGeneralError()
    }
    
    public func addSection(
        _ tableId: Int,
        _ sectionId: Int,
        _ memo: String
    ) -> AnyPublisher<Void, AddSectionError> {
        let request: AddSectionRequest = .init(sectionId, memo)
        return service.addSection(tableId, request)
            .handleEvents(receiveOutput: {
                cacheManager.addSection(for: tableId, $0.toEntity())
            })
            .asVoid()
            .mapError { error in
                if let errorCode = error.isInvalidStatusCodeWithMessage() {
                    return AddSectionError.error(with: errorCode)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

//
//  TimeTableRepository.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct TimeTableRepository: TimeTableRepositoryType {
    private let service: TimeTableServiceType
    private let cacheManager: TimeTableCacheManagerType
    
    public init(
        service: TimeTableServiceType,
        cacheManager: TimeTableCacheManagerType
    ) {
        self.service = service
        self.cacheManager = cacheManager
    }
    
    
    public func deleteTable(
        _ tableId: Int
    ) -> AnyPublisher<Void, Error> {
        service.deleteTable(tableId)
            .asVoidWithGeneralError()
    }
    
    // 현재는 테이블 아이디를 가져오는 용도로만 사용됨
    public func getTableList() -> AnyPublisher<Int?, Error> {
        service.getTableList()
            .map { $0.tables.isEmpty ? nil : $0.tables[0].tableId }
            .mapToGeneralError()
    }
    
    public func getTableDetailInfo(
            _ tableId: Int
        ) -> AnyPublisher<TimeTableDetailInfo, Error> {
            return cacheManager.getCachedTableDetailInfo(for: tableId)
                .flatMap { [service, cacheManager] cachedInfo -> AnyPublisher<TimeTableDetailInfo, Error> in
                    if let cachedInfo = cachedInfo {
                        print("✅ Cache HIT for tableId: \(tableId)")
                        return Just(cachedInfo)
                            .setFailureType(to: Error.self)
                            .eraseToAnyPublisher()
                    } else {
                        print("❌ Cache MISS for tableId: \(tableId) - Fetching from server")
                        return service.getTableDetailInfo(tableId)
                            .map { $0.toEntity() }
                            .handleEvents(receiveOutput: {
                                cacheManager.cache(tableDetailInfo: $0, for: tableId)
                            })
                            .mapToGeneralError()
                    }
                }
                .eraseToAnyPublisher()
        }
    
    public func patchTableName(
        _ tableId: Int,
        _ tableName: String
    ) -> AnyPublisher<Void, ChangeTimeTableNameError> {
        let request: TimeTableEditNameRequest = .init(tableName)
        return service.patchTableName(tableId, request)
            .asVoid()
            .mapError { error in
                if let errorMessage = error.isInvalidStatusCodeWithMessage() {
                    return ChangeTimeTableNameError.error(with: errorMessage)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func postTable() -> AnyPublisher<Int, Error> {
        let request: AddTimeTableRequest = .init("TimeTable", "TERM_2", 2024)
        return service.postTable(request)
            .map { $0.tableId }
            .mapToGeneralError()
    }
}

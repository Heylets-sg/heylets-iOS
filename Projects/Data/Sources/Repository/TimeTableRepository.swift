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
    
    public init(service: TimeTableServiceType) {
        self.service = service
    }
    
    
    public func deleteTable(
        _ tableId: String
    ) -> AnyPublisher<Void, Error> {
        service.deleteTable(tableId)
            .asVoidWithGeneralError()
    }
    
    public func getTableList(
        _ academicYear: String,
        _ semester: String
    ) -> AnyPublisher<[TimeTableInfo], Error> {
        service.getTableList(academicYear, semester)
            .map { $0.tables.map { $0.toEntity() }}
            .mapToGeneralError()
    }
    
    public func getTableDetailInfo(
        _ tableId: String
    ) -> AnyPublisher<TimeTableDetailInfo, Error> {
        service.getTableDetailInfo(tableId)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func patchTableName(
        _ tableId: String,
        _ tableName: String
    ) -> AnyPublisher<Void, Error> {
        let request: TimeTableEditNameRequest = .init(tableName)
        return service.patchTableName(tableId, request)
            .asVoidWithGeneralError()
    }
    
    public func postTable(
        _ tableName: String,
        _ semester: String,
        _ academicYear: Int
    ) -> AnyPublisher<TimeTableInfo, Error> {
        let request: AddTimeTableRequest = .init(tableName, semester, academicYear)
        return service.postTable(request)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
}

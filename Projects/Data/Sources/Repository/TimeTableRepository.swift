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
        service.getTableDetailInfo(tableId)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func patchTableName(
        _ tableId: Int,
        _ tableName: String
    ) -> AnyPublisher<Void, Error> {
        let request: TimeTableEditNameRequest = .init(tableName)
        return service.patchTableName(tableId, request)
            .asVoidWithGeneralError()
    }
    
    public func postTable() -> AnyPublisher<Int, Error> {
        let request: AddTimeTableRequest = .init("TimeTable", "TERM_2", 2024)
        return service.postTable(request)
            .map { $0.tableId }
            .mapToGeneralError()
    }
}

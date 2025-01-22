//
//  ScheduleRepository.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct ScheduleRepository: ScheduleRepositoryType {
    private let service: ScheduleServiceType
    
    public init(service: ScheduleServiceType) {
        self.service = service
    }
    
    public func deleteLectureModule(
        _ tableId: Int,
        _ scheduleId: Int
    ) -> AnyPublisher<Void, Error> {
        service.deleteLectureModule(tableId, scheduleId)
            .asVoidWithGeneralError()
    }
    
    public func patchCustomModule(
        _ tableId: Int,
        _ scheduleId: Int,
        _ customModuleInfo: CustomModuleInfo
    ) -> AnyPublisher<CustomModuleInfo, Error> {
        let request = customModuleInfo.toDTO()
        return service.patchCustomModule(
            tableId,
            scheduleId,
            request
        )
        .map { $0.toEntity() }
        .mapToGeneralError()
    }
    
    public func addLecture(
        _ tableId: Int,
        _ scheduleId: Int,
        _ memo: String
    ) -> AnyPublisher<ModuleInfo, Error> {
        let request = AddLectureRequest(scheduleId, memo)
        return service.addLecture(tableId, request)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func addCustomModule(
        _ tableId: Int,
        _ customModuleInfo: CustomModuleInfo
    ) -> AnyPublisher<Void, Error> {
        let request = customModuleInfo.toDTO()
        return service.addCustomModule(
            tableId,
            request
        )
//        .map { $0.toEntity() }
        .map { _ in }
        .mapToGeneralError()
    }
}

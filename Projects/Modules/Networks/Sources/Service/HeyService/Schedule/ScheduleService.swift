//
//  ScheduleService.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias ScheduleService = BaseService<ScheduleAPI>

public protocol ScheduleServiceType {
    func deleteLectureModule(
        _ tableId: Int,
        _ scheduleId: Int
    ) -> NetworkVoidResponse
    
    func patchCustomModule(
        _ tableId: Int,
        _ scheduleId: Int,
        _ request: CustomModuleRequest
    ) -> NetworkDecodableResponse<CustomModuleResult>
    
    func addLecture(
        _ tableId: Int,
        _ request: AddLectureRequest
    ) -> NetworkDecodableResponse<ModuleResult>
    
    func addCustomModule(
        _ tableId: Int,
        _ request: CustomModuleRequest
    ) -> NetworkDecodableResponse<CustomModuleResult>
}

extension ScheduleService: ScheduleServiceType {
    public func deleteLectureModule(
        _ tableId: Int,
        _ scheduleId: Int
    ) -> NetworkVoidResponse {
        requestWithNoResult(.deleteModule(tableId, scheduleId))
    }
    
    public func patchCustomModule(
        _ tableId: Int,
        _ scheduleId: Int,
        _ request: CustomModuleRequest
    ) -> NetworkDecodableResponse<CustomModuleResult> {
        requestWithResult(.patchCustomModule(tableId, scheduleId, request))
    }
    
    public func addLecture(
        _ tableId: Int,
        _ request: AddLectureRequest
    ) -> NetworkDecodableResponse<ModuleResult> {
        requestWithResult(.addModule(tableId, request))
    }
    
    public func addCustomModule(
        _ tableId: Int,
        _ request: CustomModuleRequest
    ) -> NetworkDecodableResponse<CustomModuleResult> {
        requestWithResult(.addCustomModule(tableId, request))
    }
}

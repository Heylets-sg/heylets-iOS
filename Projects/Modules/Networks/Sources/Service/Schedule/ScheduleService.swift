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
        _ tableId: String,
        _ scheduleId: String
    ) -> NetworkVoidResponse
    
    func patchCustomModule(
        _ tableId: String,
        scheduleId: String, 
        _ request: CustomModuleRequest
    ) -> NetworkDecodableResponse<ModuleResult>
    
    func addLecture(
        _ tableId: String,
        _ request: AddLectureRequest
    ) -> NetworkDecodableResponse<ModuleResult>
    
    func addCustomModule(
        _ tableId: String,
        _ request: CustomModuleRequest
    ) -> NetworkDecodableResponse<ModuleResult>
}

extension ScheduleService: ScheduleServiceType {
    public func deleteLectureModule(
        _ tableId: String,
        _ scheduleId: String
    ) -> NetworkVoidResponse {
        requestWithNoResult(.deleteModule(tableId, scheduleId))
    }
    
    public func patchCustomModule(
        _ tableId: String,
        scheduleId: String,
        _ request: CustomModuleRequest
    ) -> NetworkDecodableResponse<ModuleResult> {
        requestWithResult(.patchCustomModule(tableId, scheduleId, request))
    }
    
    public func addLecture(
        _ tableId: String,
        _ request: AddLectureRequest
    ) -> NetworkDecodableResponse<ModuleResult> {
        requestWithResult(.addModule(tableId, request))
    }
    
    public func addCustomModule(
        _ tableId: String,
        _ request: CustomModuleRequest
    ) -> NetworkDecodableResponse<ModuleResult> {
        requestWithResult(.addCustomModule(tableId, request))
    }
}

//
//  ScheduleRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol ScheduleRepositoryType {
    func deleteLectureModule(
        _ tableId: String,
        _ scheduleId: String
    ) -> AnyPublisher<Void, Error>
    
    func patchCustomModule(
        _ tableId: String,
        _ scheduleId: String,
        _ customModuleInfo: CustomModuleInfo
    ) -> AnyPublisher<CustomModuleInfo, Error>
    
    func addLecture(
        _ tableId: String,
        _ scheduleId: Int,
        _ memo: String
    ) -> AnyPublisher<ModuleInfo, Error>
    
    func addCustomModule(
        _ tableId: String,
        _ customModuleInfo: CustomModuleInfo
    ) -> AnyPublisher<CustomModuleInfo, Error>
}


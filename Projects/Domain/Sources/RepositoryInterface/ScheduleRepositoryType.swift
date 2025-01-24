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
        _ tableId: Int,
        _ scheduleId: Int
    ) -> AnyPublisher<Void, Error>
    
    func patchCustomModule(
        _ tableId: Int,
        _ scheduleId: Int,
        _ customModuleInfo: CustomModuleInfo
    ) -> AnyPublisher<CustomModuleInfo, Error>
    
    func addLecture(
        _ tableId: Int,
        _ scheduleId: Int,
        _ memo: String
    ) -> AnyPublisher<ModuleInfo, Error>
    
    func addCustomModule(
        _ tableId: Int,
        _ customModuleInfo: CustomModuleInfo
    ) -> AnyPublisher<Void, AddSectionError>
}


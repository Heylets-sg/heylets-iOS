////
////  ScheduleRepository.swift
////  Data
////
////  Created by 류희재 on 1/9/25.
////  Copyright © 2025 Heylets-iOS. All rights reserved.
////
//
//import Foundation
//import Combine
//
//import Domain
//import Networks
//
//public struct ScheduleRepository: ScheduleRepositoryType {
//    public func deleteLectureModule(_ tableId: String, _ scheduleId: String) -> AnyPublisher<Void, any Error> {
//        <#code#>
//    }
//    
//    public func patchCustomModule(_ tableId: String, scheduleId: String, _ customModuleInfo: Domain.CustomModuleInfo) -> AnyPublisher<Domain.CustomModuleInfo, any Error> {
//        <#code#>
//    }
//    
//    public func addLecture(_ tableId: String, _ scheduleId: Int, _ memo: String) -> AnyPublisher<Domain.ModuleInfo, any Error> {
//        <#code#>
//    }
//    
//    public func addCustomModule(_ tableId: String, _ customModuleInfo: Domain.CustomModuleInfo) -> AnyPublisher<Domain.CustomModuleInfo, any Error> {
//        <#code#>
//    }
//    
//    private let scheduleService: ScheduleServiceType
//    
//    public init(scheduleService: ScheduleServiceType) {
//        self.scheduleService = scheduleService
//    }
//}

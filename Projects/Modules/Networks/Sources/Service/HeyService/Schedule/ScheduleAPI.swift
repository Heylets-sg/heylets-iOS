//
//  ScheduleAPI.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum ScheduleAPI {
    case deleteModule(String, String)
    case patchCustomModule(String, String, CustomModuleRequest)
    case addModule(String, AddLectureRequest)
    case addCustomModule(String, CustomModuleRequest)
}

extension ScheduleAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
        switch self {
        case .deleteModule(let tableId, let scheduleId):
            return Paths.deleteLectureModule
                .replacingOccurrences(of: "{tableId}", with: tableId)
                .replacingOccurrences(of: "{scheduleId}", with: scheduleId)
        case .patchCustomModule(let tableId, let scheduleId, _):
            return Paths.patchCustomModule
                .replacingOccurrences(of: "{tableId}", with: tableId)
                .replacingOccurrences(of: "{scheduleId}", with: scheduleId)
        case .addModule(let tableId, _):
            return Paths.addLectureModule
                .replacingOccurrences(of: "{tableId}", with: tableId)
        case .addCustomModule(let tableId, _):
            return Paths.addCustomLectureModule
                .replacingOccurrences(of: "{tableId}", with: tableId)
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .deleteModule:
            return .delete
        case .patchCustomModule:
            return .patch
        case .addModule:
            return .post
        case .addCustomModule:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .deleteModule:
            return .requestPlain
        case .patchCustomModule(_, _, let request):
            return .requestJSONEncodable(request)
        case .addModule(_, let request):
            return .requestJSONEncodable(request)
        case .addCustomModule(_, let request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String : String]? {
        return APIHeaders.headerWithAccessToken
    }
}





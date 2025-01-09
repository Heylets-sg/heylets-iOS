//
//  TimeTableAPI.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum TimeTableAPI {
    case deleteTable(String)
    case getTableList(String, String)
    case getTableDetailInfo(String)
    case patchTable(String, TimeTableEditNameRequest)
    case postTable(AddTimeTableRequest)
}

extension TimeTableAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
        switch self {
        case .deleteTable(let tableId):
            return Paths.deleteTable
                .replacingOccurrences(of: "{tableId}", with: tableId)
        case .getTableList:
            return Paths.getTableList
        case .getTableDetailInfo(let tableId):
            return Paths.getTableDetailInfo
                .replacingOccurrences(of: "{tableId}", with: tableId)
        case .patchTable(let tableId, _):
            return Paths.patchTable
                .replacingOccurrences(of: "{tableId}", with: tableId)
        case .postTable:
            return Paths.postTable
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .deleteTable:
            return .delete
        case .getTableList:
            return .get
        case .getTableDetailInfo:
            return .get
        case .patchTable:
            return .patch
        case .postTable:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .deleteTable:
            return .requestPlain
        case .getTableList(let academicYear, let semester):
            return .requestParameters(["academicYear": academicYear, "semester": semester])
        case .getTableDetailInfo:
            return .requestPlain
        case .patchTable(_, let request):
            return .requestJSONEncodable(request)
        case .postTable(let request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String : String]? {
        return APIHeaders.defaultHeader
    }
}








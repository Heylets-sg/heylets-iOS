//
//  SectionAPI.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum SectionAPI {
    case deleteAllSection(String)
    case deleteSection(String, String)
    case addSection(String, AddSectionRequest)
}

extension SectionAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
        switch self {
        case .deleteAllSection(let tableId):
            return Paths.deleteAllSection
                .replacingOccurrences(of: "{tableId}", with: tableId)
        case .deleteSection(let tableId, let sectionId):
            return Paths.deleteLectureSection
                .replacingOccurrences(of: "{tableId}", with: tableId)
                .replacingOccurrences(of: "{sectionId}", with: sectionId)
        case .addSection(let tableId, _):
            return Paths.addLectureSection
                .replacingOccurrences(of: "{tableId}", with: tableId)
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .deleteAllSection:
            return .delete
        case .deleteSection:
            return .delete
        case .addSection:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .deleteAllSection:
            return .requestPlain
        case .deleteSection:
            return .requestPlain
        case .addSection(_, let request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String : String]? {
        return APIHeaders.headerWithAccessToken
    }
}






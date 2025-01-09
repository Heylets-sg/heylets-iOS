//
//  ThemeAPI.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum ThemeAPI {
    case getThemeDetailInfo(String)
    case getPreviewTheme
}

extension ThemeAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
        switch self {
        case .getThemeDetailInfo(let themeName):
            return Paths.getThemeDetailInfo
                .replacingOccurrences(of: "{themeName}", with: themeName)
        case .getPreviewTheme:
            return Paths.getPreviewTheme
        }
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return APIHeaders.defaultHeader
    }
}

//
//  ThemeAPI.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum SettingAPI {
    case getThemeDetailInfo(String)
    case getPreviewTheme
    case getTimeTableSetting
    case patchTimeTableSetting(TimeTableSettingRequest)
}

extension SettingAPI: BaseAPI {
    public var connectWebHook: Bool {
        return false
    }
    
    public var isWithInterceptor: Bool {
        return true
    }
    
    public var path: String? {
        switch self {
        case .getThemeDetailInfo(let themeName):
            return Paths.getThemeDetailInfo
                .replacingOccurrences(of: "{themeName}", with: themeName)
        case .getPreviewTheme:
            return Paths.getPreviewTheme
        case .getTimeTableSetting:
            return Paths.getTimeTableSetting
        case .patchTimeTableSetting:
            return Paths.patchTimeTableSetting
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .patchTimeTableSetting:
            return .patch
        default:
            return .get
        }
        
    }
    
    public var task: Task {
        switch self {
        case .patchTimeTableSetting(let request):
            return .requestJSONEncodable(request)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        return APIHeaders.headerWithAccessToken
    }
}

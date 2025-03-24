//
//  NotificationAPI.swift
//  Networks
//
//  Created by 류희재 on 3/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum NotificationAPI {
    case deleteNotificationSetting
    case getNotificationSetting
    case putNotificationSettting(NotificationSettingDTO)
}

extension NotificationAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
        return Paths.notificationSetting
    }
    
    public var method: HTTPMethod {
        switch self {
        case .deleteNotificationSetting:
            return .delete
        case .getNotificationSetting:
            return .get
        case .putNotificationSettting:
            return .put
        }
    }
    
    public var task: Task {
        switch self {
        case .deleteNotificationSetting:
            return .requestPlain
        case .getNotificationSetting:
            return .requestPlain
        case .putNotificationSettting(let request):
            return .requestJSONEncodable(request)
        }
        
    }
    
    public var headers: [String : String]? {
        return APIHeaders.headerWithAccessToken
    }
}

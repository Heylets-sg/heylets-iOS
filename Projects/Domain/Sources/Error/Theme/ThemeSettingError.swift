//
//  ThemeSettingError.swift
//  Domain
//
//  Created by 류희재 on 3/10/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Foundation

public enum ThemeSettingError: Error {
    case invalidModuleDisplayType
    case userNotFound
    case dataPreferenceCreationFailed
    case guestAccessDenied
    case unknown
    
    var description: String {
        switch self {
        case .invalidModuleDisplayType:
            return "INVALID MODULE DISPLAY TYPE"
        case .userNotFound:
            return "User Not Found"
        case .dataPreferenceCreationFailed:
            return "Server Error"
        case .guestAccessDenied:
            return "The guest user cannot access the custom module."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
    
    var isGuestModeError: Bool {
        return self == .guestAccessDenied
    }
}

extension ThemeSettingError {
    static public func error(with message: String) -> ThemeSettingError {
        switch message {
        case "유효하지 않은 시간표 모듈 표시 방식입니다.":
            return .invalidModuleDisplayType
        case "사용자를 찾을 수 없습니다.":
            return .userNotFound
        case "기본 사용자 선호도 생성에 실패했습니다.":
            return .dataPreferenceCreationFailed
        case "게스트 토큰으로 접근할 수 없습니다.":
            return .guestAccessDenied
        default:
            return .unknown
        }
    }
}



//    .mapError { error in
//        if let errorCode = error.isInvalidStatusCode() {
//            return LoginError.error(with: errorCode)
//        } else {
//            return .unknown
//        }
//    }

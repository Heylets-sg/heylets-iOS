//
//  ChangeTimeTableNameError.swift
//  Domain
//
//  Created by 류희재 on 3/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum ChangeTimeTableNameError: Error {
    case unauthorizedUser
    case userNotFound
    case guestAccessDenied
    case unknown
    
    var description: String {
        switch self {
        case .unauthorizedUser:
            return "unauthorizedUser"
        case .userNotFound:
            return "User Not Found"
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

extension ChangeTimeTableNameError {
    static public func error(with message: String) -> ChangeTimeTableNameError {
        switch message {
        case "권한이 없는 사용자입니다.":
            return .unauthorizedUser
        case "사용자를 찾을 수 없습니다.":
            return .userNotFound
        case "게스트 토큰으로 접근할 수 없습니다.":
            return .guestAccessDenied
        default:
            return .unknown
        }
    }
}


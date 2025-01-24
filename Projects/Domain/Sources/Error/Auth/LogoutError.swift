//
//  LogoutError.swift
//  Domain
//
//  Created by 류희재 on 1/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum LogoutError: Error {
    case invalidRequest
    case unAuthenticationRequest
    case noPermission
    case noDevice
    case unknown
    
    var description: String {
        switch self {
        case .invalidRequest:
            return "There was an issue with your request."
        case .unAuthenticationRequest:
            return "Your session has expired. Please log in again."
        case .noPermission:
            return "You don't have permission to access logout"
        case .noDevice:
            return "We couldn't find your device."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}

extension LogoutError {
    static public func error(with statusCode: Int?) -> LogoutError {
        switch statusCode {
        case 400:
            return .invalidRequest
        case 401:
            return .unAuthenticationRequest
        case 403:
            return .noPermission
        case 404:
            return .noDevice
        default:
            return .unknown
        }
    }
}

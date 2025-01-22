//
//  LoginError.swift
//  Domain
//
//  Created by 류희재 on 1/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum LoginError: Error {
    case invalidRequestData
    case authenticationFailed
    case userNotFound
    case accountDisabled
    case exceededNumOfDevices
    case unknown
    
    var description: String {
        switch self {
        case .invalidRequestData:
            return "The email or password format is incorrect."
        case .authenticationFailed, .userNotFound:
            return "The account information does not match. \nPlease check your email or password."
        case .accountDisabled:
            return "The account is inactive(deactivated)."
        case .exceededNumOfDevices:
            return "You have exceeded the number of devices allowed for login."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}

extension LoginError {
    static public func error(with statusCode: Int?) -> LoginError {
        switch statusCode {
        case 400:
            return .invalidRequestData
        case 401:
            return .authenticationFailed
        case 403:
            return .accountDisabled
        case 404:
            return .userNotFound
        case 429:
            return .exceededNumOfDevices
        default:
            return .unknown
        }
    }
}

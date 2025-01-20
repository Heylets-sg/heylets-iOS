//
//  EmailVerificationRequestError.swift
//  Domain
//
//  Created by 류희재 on 1/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum VerificationRequestError: Error {
    case validationFailed
    case emailAlreadyRegistered
    case requestLimitExceeded
    case emailDeliveryFailed
    case unknown
    
    var description: String {
        switch self {
        case .validationFailed:
            return "Invalid request data.\nEnsure all fields are correctly filled."
        case .emailAlreadyRegistered:
            return "This email is already registered.\nPlease use a different email address."
        case .requestLimitExceeded:
            return "You’ve made too many requests.\nPlease try again later."
        case .emailDeliveryFailed:
            return "Failed to send the verification email.\nPlease try again later."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}

extension VerificationRequestError {
    static public func error(with statusCode: Int?) -> VerificationRequestError {
        switch statusCode {
        case 400:
            return .validationFailed
        case 409:
            return .emailAlreadyRegistered
        case 429:
            return .requestLimitExceeded
        case 500:
            return .emailDeliveryFailed
        default:
            return .unknown
        }
    }
}


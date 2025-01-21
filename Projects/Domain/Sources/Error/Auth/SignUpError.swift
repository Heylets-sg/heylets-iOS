//
//  SignUpError.swift
//  Domain
//
//  Created by 류희재 on 1/21/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum SignUpError: Error {
    case invalidRequestData
    case emailNotAuthenticated
    case duplicateNicknameOrEmail
    case imageSizeExceeded
    case unknown
    
    var description: String {
        switch self {
        case .invalidRequestData:
            return "Invalid member information data."
        case .emailNotAuthenticated:
            return "The email has not been verified."
        case .duplicateNicknameOrEmail:
            return "Duplicate nickname or email."
        case .imageSizeExceeded:
            return "Image size exceeded error."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}

extension SignUpError {
    static public func error(with statusCode: Int?) -> SignUpError {
        switch statusCode {
        case 400:
            return .invalidRequestData
        case 401:
            return .emailNotAuthenticated
        case 409:
            return .duplicateNicknameOrEmail
        case 413:
            return .imageSizeExceeded
        default:
            return .unknown
        }
    }
}

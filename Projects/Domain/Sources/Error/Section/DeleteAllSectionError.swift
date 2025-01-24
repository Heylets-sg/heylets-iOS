//
//  DeleteAllSectionError.swift
//  Domain
//
//  Created by 류희재 on 1/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum DeleteAllSectionError: Error {
    case invalidRequestData
    case unAuthenticatedUser
    case noPermission
    case timeTableNotFound
    case unknown
    
    var description: String {
        switch self {
        case .invalidRequestData:
            return "Invalid request data.\nEnsure all fields are correctly filled."
        case .unAuthenticatedUser:
            return "Not authorized to delete "
        case .noPermission:
            return "No Permission"
        case .timeTableNotFound:
            return "The schedule cannot be found."
        case .unknown:
            return "An unknown error has occurred."
        }
    }
}

extension DeleteAllSectionError {
    static public func error(with statusCode: Int) -> DeleteAllSectionError {
        switch statusCode {
        case 400:
            return .invalidRequestData
        case 401:
            return .unAuthenticatedUser
        case 403:
            return .noPermission
        case 404:
            return .timeTableNotFound
        default:
            return .unknown
        }
    }
}



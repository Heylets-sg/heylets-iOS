//
//  PasswordError.swift
//  Domain
//
//  Created by 류희재 on 1/11/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum PasswordError: Error {
    case inValidCurrentPassword
    case inValidCheckPassword
    
    public var message: String {
        switch self {
        case .inValidCurrentPassword:
            return "inValidCurrentPassword"
        case .inValidCheckPassword:
            return "inValidCheckPassword"
        }
    }
}

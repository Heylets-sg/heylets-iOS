//
//  TextFieldStateStyle.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public enum TextFieldState {
    case idle
    case valid
    case invalid
    
    public var strokeColor: Color {
        switch self {
        case .idle:
            return .clear
        case .valid:
            return .common.Success.default
        case .invalid:
            return .common.Error.default
        }
    }
    
    var image: Image? {
        switch self {
        case .valid:
            return .icSuccess
        default:
            return nil
        }
    }
    
    func isValid() -> Bool {
        return self == .valid
    }
}

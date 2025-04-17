//
//  AlertButtonColorStyle.swift
//  DSKit
//
//  Created by 류희재 on 4/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

public enum HeyAlertButtonColorStyle {
    case primary
    case gray
    case error
    
    var textColor: Color {
        switch self {
        case .primary: .popup.Text.default
        case .gray: .common.Placeholder.default
        case .error: .heyWhite
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .primary: .popup.Button.default
        case .gray: .common.InputField.default
        case .error: .common.Error.default
        }
    }
}

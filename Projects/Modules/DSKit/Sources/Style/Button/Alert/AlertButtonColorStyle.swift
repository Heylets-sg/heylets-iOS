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
    
    var color: Color {
        switch self {
        case .primary: .popup.Button.default
        case .gray: .popup.Button.expect
        case .error: .common.Error.default
        }
    }
}

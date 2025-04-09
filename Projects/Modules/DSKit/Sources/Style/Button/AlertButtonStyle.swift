//
//  AlertButtonStyle.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public enum AlertButtonType {
    case primary
    case except
    
    var color: Color {
        switch self {
        case .primary: .popup.Button.default
        case .except: .popup.Button.expect
        }
    }
}

struct HeyAlertButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private let type: AlertButtonType
    
    init(_ type: AlertButtonType) {
        self.type = type
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 46)
            .frame(maxWidth: .infinity)
            .font(.medium_16)
            .background(Color.popup.default)
            .foregroundStyle(type.color)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

public extension View {
    func heyAlertButtonStyle(_ type: AlertButtonType) -> some View {
        self.buttonStyle(HeyAlertButtonStyle(type))
    }
}


//
//  AlertButtonStyle.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct HeyAlertButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private let colorStyle: HeyAlertButtonColorStyle
    private let height: CGFloat
    
    init(
        _ colorStyle: HeyAlertButtonColorStyle,
        _ height: CGFloat
    ) {
        self.colorStyle = colorStyle
        self.height = height
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: height)
            .frame(maxWidth: .infinity)
            .font(.medium_16)
            .background(colorStyle.backgroundColor)
            .foregroundStyle(colorStyle.textColor)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

public extension View {
    func heyAlertButtonStyle(
        _ style: HeyAlertButtonColorStyle,
        _ height: CGFloat = 46
    ) -> some View {
        self.buttonStyle(HeyAlertButtonStyle(style, height))
    }
}

//
//  ButtonStyle.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct HeyCTAButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private let colorStyle: HeyCTAButtonColorStyle
    private let cornerRadius: CGFloat
    
    init(
        _ colorStyle: HeyCTAButtonColorStyle,
        cornerRadius: CGFloat
    ) {
        self.colorStyle = colorStyle
        self.cornerRadius = cornerRadius
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 56)
            .font(.semibold_14)
            .frame(maxWidth: .infinity)
            .background(isEnabled ? colorStyle.background : colorStyle.disabledBackground)
            .foregroundStyle(isEnabled ? colorStyle.foreground : colorStyle.disabledForeground)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension View {
    public func heyCTAButtonStyle(_ colorStyle: HeyCTAButtonColorStyle = .primary, cornerRadius: CGFloat = 28) -> some View {
        self.buttonStyle(HeyCTAButtonStyle(colorStyle, cornerRadius: cornerRadius))
    }
}


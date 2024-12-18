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

struct HeyButtonColorStyle {
    let background: Color
    let foreground: Color
    let disabledBackground: Color
}

extension HeyButtonColorStyle {
    static let white = HeyButtonColorStyle(
        background: .heyWhite,
        foreground: .heyBlack,
        disabledBackground: .heyGray4
    )
    
    static let primary = HeyButtonColorStyle(
        background: .heyMain,
        foreground: .heyBlack,
        disabledBackground: .heyGray4
    )
    
    static let black = HeyButtonColorStyle(
        background: .heyBlack,
        foreground: .heyWhite,
        disabledBackground: .heyGray4
    )
}


struct HeyBottomButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private let colorStyle: HeyButtonColorStyle
    
    init(_ colorStyle: HeyButtonColorStyle) {
        self.colorStyle = colorStyle
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: 56)
            .frame(maxWidth: .infinity)
            .font(.semibold_14)
            .background(isEnabled ? colorStyle.background : colorStyle.disabledBackground)
            .foregroundStyle(colorStyle.foreground)
            .clipShape(RoundedRectangle(cornerRadius: 28))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension View {
    func heyBottomButtonStyle(_ colorStyle: HeyButtonColorStyle = .white) -> some View {
        self.buttonStyle(HeyBottomButtonStyle(colorStyle))
    }
}


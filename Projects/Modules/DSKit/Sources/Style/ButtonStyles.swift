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
    static let red = HeyButtonColorStyle(background: .red, foreground: .white, disabledBackground: .gray)
    static let darkgray = HeyButtonColorStyle(background: .gray, foreground: .white, disabledBackground: .gray)
}

enum HeyButtonSizeStyle {
    case large
    case medium
    
    var height: CGFloat {
        switch self {
        case .large:
            52
        case .medium:
            52
        }
    }
    
    var font: Font {
        switch self {
        case .large:
            return .semibold_14
        case .medium:
            return .semibold_18
        }
    }
}


struct HeyBottomButtonStyle: ButtonStyle {
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    
    private let colorStyle: HeyButtonColorStyle
    private let sizeStyle: HeyButtonSizeStyle
    
    init(_ colorStyle: HeyButtonColorStyle, _ sizeStyle : HeyButtonSizeStyle) {
        self.colorStyle = colorStyle
        self.sizeStyle = sizeStyle
    }

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(height: sizeStyle.height)
            .frame(maxWidth: .infinity)
            .font(sizeStyle.font)
            .background(isEnabled ? colorStyle.background : colorStyle.disabledBackground)
            .foregroundStyle(colorStyle.foreground)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

extension View {
    func smBottomButtonStyle(_ colorStyle: HeyButtonColorStyle = .red, _ sizeStyle: HeyButtonSizeStyle = .large) -> some View {
        self.buttonStyle(HeyBottomButtonStyle(colorStyle, sizeStyle))
    }
}


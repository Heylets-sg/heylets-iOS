//
//  ButtonColorStyle.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct HeyCTAButtonColorStyle: Sendable {
    let background: Color
    let foreground: Color
    let disabledForeground: Color
    let disabledBackground: Color
    
    init(
        background: Color,
        foreground: Color,
        disabledForeground: Color = .common.MainText.default,
        disabledBackground: Color = .common.Background.default
    ) {
        self.background = background
        self.foreground = foreground
        self.disabledForeground = disabledForeground
        self.disabledBackground = disabledBackground
    }
}

extension HeyCTAButtonColorStyle {
    public static let white = HeyCTAButtonColorStyle(
        background: .common.CTA.onboarding,
        foreground: .common.CTAText.unactive
    )
    
    public static let primary = HeyCTAButtonColorStyle(
        background: .common.CTA.active,
        foreground: .common.CTAText.active,
        disabledForeground: .common.CTAText.unactive,
        disabledBackground: .common.CTA.unactive
    )
}

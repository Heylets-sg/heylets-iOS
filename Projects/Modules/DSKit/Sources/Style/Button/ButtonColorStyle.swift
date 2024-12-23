//
//  ButtonColorStyle.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct HeyButtonColorStyle {
    let background: Color
    let foreground: Color
    let disabledBackground: Color
}

extension HeyButtonColorStyle {
    public static let white = HeyButtonColorStyle(
        background: .heyWhite,
        foreground: .heyBlack,
        disabledBackground: .heyGray4
    )
    
    public static let primary = HeyButtonColorStyle(
        background: .heyMain,
        foreground: .heyBlack,
        disabledBackground: .heyGray4
    )
    
    public static let black = HeyButtonColorStyle(
        background: .heyBlack,
        foreground: .heyWhite,
        disabledBackground: .heyGray4
    )
    
    public static let error = HeyButtonColorStyle(
        background: .heyError,
        foreground: .heyWhite,
        disabledBackground: .heyGray4
    )
    
    //TODO: 피그마 디자인 시스템 적용시 값 변경
    public static let gray = HeyButtonColorStyle(
        background: .heyGray4,
        foreground: .heyGray2,
        disabledBackground: .heyGray4
    )
}

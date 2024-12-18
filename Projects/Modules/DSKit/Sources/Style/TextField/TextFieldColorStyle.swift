//
//  TextFieldColorStyle.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct HeyTextFieldColorStyle {
    let background: Color
    let foreground: Color
}


extension HeyTextFieldColorStyle {
    static let white = HeyTextFieldColorStyle(background: .heyWhite, foreground: .heyBlack)
    static let heyGray4 = HeyTextFieldColorStyle(background: .heyGray4, foreground: .heyBlack)
}

//
//  TextFieldStyles.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

struct HeyTextFieldColorStyle {
    let background: Color
    let foreground: Color
    let disabledBackground: Color
}

extension HeyTextFieldColorStyle {
    static let white = HeyTextFieldColorStyle(background: .white, foreground: .black, disabledBackground: .gray)
    static let primary = HeyTextFieldColorStyle(background: .white, foreground: .black, disabledBackground: .gray)
    static let gray = HeyTextFieldColorStyle(background: .white, foreground: .black, disabledBackground: .gray)
}

struct HeyTextFieldStlyes: TextFieldStyle {
    
    private let colorStyle: HeyTextFieldColorStyle
    
    init(_ colorStyle: HeyTextFieldColorStyle) {
        self.colorStyle = colorStyle
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.medium_14)
            .foregroundColor(colorStyle.foreground)
            .padding(.vertical, 16)
            .padding(.leading, 12)
            .frame(height: 52)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gray, lineWidth: 1)
            }
    }
}

extension View {
    func heyTextFieldStyle(_ colorStyle: HeyTextFieldColorStyle = .white) -> some View {
        self.textFieldStyle(HeyTextFieldStlyes(colorStyle))
    }
}

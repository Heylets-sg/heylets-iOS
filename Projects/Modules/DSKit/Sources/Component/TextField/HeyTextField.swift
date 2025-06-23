//
//  HeyTextField.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct HeyTextField: View {
    @Binding var text: String
    let placeHolder: String
    let leftImage: Image?
    let rightImage: Image?
    @Binding var textFieldState: TextFieldState
    let colorSystem: HeyTextFieldColorStyle
    let action: () -> Void
    
    public init(
        text: Binding<String>,
        placeHolder: String,
        leftImage: Image? = nil,
        rightImage: Image? = nil,
        textFieldState: Binding<TextFieldState> = .constant(.idle),
        colorSystem: HeyTextFieldColorStyle = .white,
        action: @escaping () -> Void = {}
    ) {
        self._text = text
        self.placeHolder = placeHolder
        self.leftImage = leftImage
        self.rightImage = rightImage
        self._textFieldState = textFieldState
        self.colorSystem = colorSystem
        self.action = action
    }
    
    
    public var body: some View {
        HStack {
            if let image = leftImage { image }
            
            TextField(
                "",
                text: $text,
                prompt: Text(placeHolder)
                    .foregroundColor(.common.Placeholder.default)
            )
            .heyTextFieldStyle()
            
            if let image = rightImage {
                Button(action: self.action) { image }
            } else {
                if let image = textFieldState.image { image }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 52)
        .background(colorSystem.background)
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(textFieldState.strokeColor, lineWidth: 2)
        )
    }
}


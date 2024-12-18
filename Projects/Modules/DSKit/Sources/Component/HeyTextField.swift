//
//  HeyTextField.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct HeyTextField: View {
    @Binding var text: String
    let placeHolder: String
    let image: UIImage?
    @State var textFieldState: TextFieldState
    let colorSystem: HeyTextFieldColorStyle
    let action: () -> Void
    
    init(
        text: Binding<String>,
        placeHolder: String,
        image: UIImage? = nil,
        textFieldState: TextFieldState = .idle,
        colorSystem: HeyTextFieldColorStyle = .white,
        action: @escaping () -> Void = {}
    ) {
        self._text = text
        self.placeHolder = placeHolder
        self.image = image
        self._textFieldState = State(initialValue: textFieldState)
        self.colorSystem = colorSystem
        self.action = action
    }
    
    
    var body: some View {
        HStack {
            TextField(
                "",
                text: $text,
                prompt: Text(placeHolder)
                    .foregroundColor(.heyGray2)
            )
            .heyTextFieldStyle()
            
            if let image = textFieldState.image {
                Image(uiImage: image)
            } else {
                if let image = image {
                    Button(action: self.action) {
                        Image(uiImage: image)
                    }
                }
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


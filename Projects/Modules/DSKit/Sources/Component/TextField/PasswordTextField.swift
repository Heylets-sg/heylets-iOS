//
//  PasswordTextField.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct PasswordField: View {
    @Binding var password: String
    @Binding var showPassword: Bool
    
    let isRest: Bool
    var textFieldState: TextFieldState
    let colorSystem: HeyTextFieldColorStyle
    
    init(
        password: Binding<String>,
        showPassword: Binding<Bool>,
        isRest: Bool = false,
        textFieldState: TextFieldState = .idle,
        colorSystem: HeyTextFieldColorStyle = .white
    ) {
        self._password = password
        self._showPassword = showPassword
        self.isRest = isRest
        self.textFieldState = textFieldState
        self.colorSystem = colorSystem
    }
    
    var body: some View {
        HStack {
            if !showPassword || isRest  {
                SecureField(
                    "",
                    text: $password,
                    prompt: Text("Password")
                        .foregroundColor(.heyGray2)
                )
                .heyTextFieldStyle()
            } else {
                TextField(
                    "",
                    text: $password,
                    prompt: Text("Password")
                        .foregroundColor(.heyGray2)
                )
                .heyTextFieldStyle()
            }
            
            if isRest && textFieldState.isValid() {
                Image(uiImage: textFieldState.image!)
            } else {
                Button(action: { self.showPassword.toggle() }) {
                    Image(uiImage: showPassword ? .icShow : .icHide)
                        .foregroundColor(.secondary)
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

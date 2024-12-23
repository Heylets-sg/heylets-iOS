//
//  PasswordTextField.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct PasswordField: View {
    @Binding var password: String
    @Binding var showPassword: Bool
    
    let isRest: Bool
    let placeHolder: String
    var textFieldState: TextFieldState
    let colorSystem: HeyTextFieldColorStyle
    
    public init(
        password: Binding<String>,
        showPassword: Binding<Bool>,
        placeHolder: String = "Password",
        isRest: Bool = false,
        textFieldState: TextFieldState = .idle,
        colorSystem: HeyTextFieldColorStyle = .gray
    ) {
        self._password = password
        self._showPassword = showPassword
        self.placeHolder = placeHolder
        self.isRest = isRest
        self.textFieldState = textFieldState
        self.colorSystem = colorSystem
    }
    
    public var body: some View {
        HStack {
            if !showPassword || isRest  {
                SecureField(
                    "",
                    text: $password,
                    prompt: Text(placeHolder)
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
            
            if isRest {
                if textFieldState.isValid() {
                    Image(uiImage: textFieldState.image!)
                }
            }
            else {
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

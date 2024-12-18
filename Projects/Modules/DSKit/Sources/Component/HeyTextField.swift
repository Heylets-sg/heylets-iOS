//
//  HeyTextField.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct HeyTextField: View {
    @Binding var password: String
    @Binding var showPassword: Bool
    var placeholder: String = "Password"
    
    var body: some View {
        HStack {
            if showPassword {
                TextField(placeholder, text: $password)
                    .heyTextFieldStyle()
            } else {
                SecureField(placeholder, text: $password)
                    .heyTextFieldStyle()
            }
            Button(action: { self.showPassword.toggle() }) {
                Image(systemName: showPassword ? "eye.slash" : "eye")
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Capsule().fill(Color.white))
    }
}


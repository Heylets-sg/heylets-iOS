//
//  SubView.swift
//  DSKit
//
//  Created by 류희재 on 12/24/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI


public struct SubView: View {
    @State var text = ""
    @State var showPassword = false
    
    public var body: some View {
        MyPageBaseView(content: {
            VStack(alignment: .leading) {
                Text("Current Password")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
                    .padding(.top, 36)
                
                HeyTextField(text: $text, placeHolder: "Email")
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.heyGray3, lineWidth: 1)
                    )
                    .padding(.top, 8)
                
                Spacer()
                    .frame(height: 32)
                
                Text("New password")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
                
                PasswordField(
                    password: $text,
                    showPassword: $showPassword,
                    placeHolder: "New password",
                    isRest: true,
                    textFieldState: .idle,
                    colorSystem: .lightgray
                )
                .padding(.top, 8)
                
                PasswordField(
                    password: $text,
                    showPassword: $showPassword,
                    placeHolder: "Confirm password",
                    isRest: true,
                    textFieldState: .idle,
                    colorSystem: .lightgray
                )
                .padding(.top, 8)
                
                Spacer()
                
                Button("Change password"){
                    
                }.heyBottomButtonStyle(.primary)
                
                Spacer()
                    .frame(height: 65)
            }
            
        }, titleText: "Change Password")
    }
}

#Preview {
    SubView()
}

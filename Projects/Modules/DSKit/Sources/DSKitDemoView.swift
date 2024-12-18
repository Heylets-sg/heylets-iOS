//
//  DSKitDemoView.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
public struct DSKitDemoView: View {
    public init() {}
    public var body: some View {
        NavigationStack {
            List {
                NavigationLink("HeyBottomButton", destination: {heyBottomButton})
                NavigationLink("HeyTextField", destination: {heyTextField})
            }
        }
        
    }
    
    //MARK: - heyBottomButtonView
    
    @State var buttonDisabled = false
    var heyBottomButton: some View {
        VStack {
            Spacer()
            
            //MARK: Case 1
            Button("기본 바텀 버튼") {
                // Action
            }
            .heyBottomButtonStyle()
            
            //MARK: Case 2
            Button("기본 바텀 버튼") {
                // Action
            }
            .heyBottomButtonStyle(.primary)
            
            //MARK: Case 3
            Button("기본 바텀 버튼") {
                // Action
            }
            .heyBottomButtonStyle(.black)
            
            //MARK: Case 2
            Button("클릭시 비활성화 되는 버튼") {
                buttonDisabled = true
            }
            .disabled(buttonDisabled)
            .heyBottomButtonStyle()
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(.yellow)
    }
    
    //MARK: - heyTextFieldView
    
    @State var text = ""
    @State var showPassword = false
    var heyTextField: some View {
        VStack {
            Spacer()
            
            //MARK: Case 1
            PasswordField(
                password: $text,
                showPassword: $showPassword
            )
            
            //MARK: Case 2
            PasswordField(
                password: $text,
                showPassword: $showPassword,
                isRest: true
            )
            
            //MARK: Case 3
            PasswordField(
                password: $text,
                showPassword: $showPassword,
                isRest: true,
                textFieldState: .invalid
            )
            
            //MARK: Case 4
            PasswordField(
                password: $text,
                showPassword: $showPassword,
                isRest: true,
                textFieldState: .valid
            )
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(.yellow)
    }
}


#Preview {
    DSKitDemoView()
}


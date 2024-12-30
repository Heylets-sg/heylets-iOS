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
                NavigationLink("HeyPasswordTextField", destination: {passwordTextField})
                NavigationLink("HeyTextField", destination: {heyTextFieldView})
                NavigationLink("HeyAlertView", destination: {heyAlertView})
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
    var passwordTextField: some View {
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
    
    //MARK: - heyTextFieldView
    
    var heyTextFieldView: some View {
        VStack {
            Spacer()
            
            //MARK: Case 1
            HeyTextField(text: $text, placeHolder: "placeholder")
            
            //MARK: Case 2
            HeyTextField(text: $text, placeHolder: "placeholder", textFieldState: .invalid)
            HeyTextField(text: $text, placeHolder: "placeholder", textFieldState: .valid)
            
            //MARK: Case 3
            HeyTextField(text: $text, placeHolder: "placeholder", rightImage: .icRepeat)
            HeyTextField(text: $text, placeHolder: "placeholder", rightImage: .icRepeat, textFieldState: .valid)
            HeyTextField(text: $text, placeHolder: "placeholder", leftImage: .icSchool, textFieldState: .valid)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(.yellow)
    }
    
    //MARK: - heyAlertView
    
    var heyAlertView: some View {
        VStack {
            Spacer()
            
            //MARK: Case 1
            HeyAlertView(
                title: "OneButton",
                isEditedName: false,
                primaryAction: ("확인", .primary, { } )
            )
            
            //MARK: Case 2
            
            HeyAlertView(
                title: "TwoButton",
                isEditedName: false,
                primaryAction: ("확인", .primary, { } ),
                secondaryAction: ("취소", .error, { } )
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


//
//  ChangePasswordView.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import BaseFeatureDependency

public struct ChangePasswordView: View {
    @EnvironmentObject var router: Router
    var viewModel: ChangePasswordViewModel
    @State var changePasswordAlertViewIsPresented: Bool = false
    
    public init(viewModel: ChangePasswordViewModel) {
        self.viewModel = viewModel
    }
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
                    changePasswordAlertViewIsPresented = true
                }.heyBottomButtonStyle(.primary)
                
                Spacer()
                    .frame(height: 65)
            }
        }, titleText: "Change Password")
        .heyAlert(
            isPresented: changePasswordAlertViewIsPresented,
            title: "The password has been\nsuccessfully changed.\nPlease log in again",
            primaryButton: ("Ok", .gray, {
                viewModel.send(.changePasswordButtonDidTap)
            })
        )
    }

}

//#Preview {
//    ChangePasswordView(viewModel: ChangePasswordViewModel(navigationRouter: StubMyPageNavigationRouter()))
//}

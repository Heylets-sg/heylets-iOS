//
//  ChangePasswordView.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import Domain
import BaseFeatureDependency

public struct ChangePasswordView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: ChangePasswordViewModel
    
    public init(viewModel: ChangePasswordViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        MyPageBaseView(content: {
            VStack(alignment: .leading) {
                Text("Current Password")
                    .font(.medium_16)
                    .foregroundColor(.heyGray1)
                    .padding(.top, 36)
                
                HeyTextField(
                    text: $viewModel.currentPassword,
                    placeHolder: "Current Password",
                    colorSystem: .gray
                )
                .padding(.top, 8)
                
                Spacer()
                    .frame(height: 32)
                
                Text("New password")
                    .font(.medium_16)
                    .foregroundColor(.heyGray1)
                
                SecurityPasswordField(
                    password: $viewModel.newPassword,
                    placeHolder: "New Password", 
                    textFieldState: $viewModel.state.newPasswordIsValid,
                    colorSystem: .gray
                )
                .padding(.top, 8)
                
                SecurityPasswordField(
                    password: $viewModel.checkPassword,
                    placeHolder: "Confirm password",
                    textFieldState: $viewModel.state.checkPasswordIsValid,
                    colorSystem: .gray
                )
                .padding(.top, 8)
                
                Spacer()
                
                Button("Change password"){
                    viewModel.send(.changePasswordButtonDidTap)
                }
                .disabled(!viewModel.state.changePasswordButtonIsEnabled)
                .heyBottomButtonStyle(.primary)
                
                Spacer()
                    .frame(height: 65)
            }
        }, titleText: "Change Password")
        .heyAlert(
            isPresented: viewModel.state.changePasswordAlertViewIsPresented,
            title: "The password has been\nsuccessfully changed.\nPlease log in again",
            primaryButton: ("Ok", .gray, {
                viewModel.send(.changePasswordButtonDidTap)
            })
        )
    }
    
}

#Preview {
    ChangePasswordView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            useCase: StubHeyUseCase.stub.myPageUseCase
        )
    )
    .environmentObject(Router.default)
}

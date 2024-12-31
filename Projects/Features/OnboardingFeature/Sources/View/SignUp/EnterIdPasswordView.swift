//
//  EnterIdPasswordView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit

public struct EnterIdPasswordView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: EnterIdPasswordViewModel
    
    @State var text = ""
    @State var showPassword = false
    
    public init(viewModel: EnterIdPasswordViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text("Our community is anonymous!")
                .font(.regular_16)
                .foregroundColor(.heyGray1)
                .padding(.bottom, 32)
            
            VStack(spacing: 32) {
                HeyTextField(
                    text: $viewModel.nickName,
                    placeHolder: "username",
                    rightImage: .icRepeat,
                    textFieldState: $viewModel.state.nickNameIsValid,
                    colorSystem: .gray
                )
                
                PasswordField(
                    password: $viewModel.password,
                    showPassword: $showPassword,
                    textFieldState: $viewModel.state.passwordIsValid
                )
                
                SecurityPasswordField(
                    password: $viewModel.checkPassword,
                    placeHolder: "Confirm Password",
                    textFieldState: $viewModel.state.checkPasswordIsValid
                )
            }
            
        }, titleText: "Create your username\nand password", nextButtonAction: { viewModel.send(.nextButtonDidTap)
        })
    }
}

//#Preview {
//    EnterIdPasswordView()
//}

//
//  ResetPasswordView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit

public struct ResetPasswordView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: ResetPasswordViewModel
    
    public init(viewModel: ResetPasswordViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text("Resetting your password will log you out on all\ndevices.")
                .font(.regular_16)
                .foregroundColor(.heyGray1)
                .padding(.bottom, 32)
            
            VStack(spacing: 32) {
                SecurityPasswordField(
                    password: $viewModel.password,
                    textFieldState: $viewModel.state.passwordIsValid
                )
                
                SecurityPasswordField(
                    password: $viewModel.checkPassword,
                    placeHolder: "Confirm Password",
                    textFieldState: $viewModel.state.checkPasswordIsValid
                )
            }
            
        }, titleText: "Reset your password", hiddenCloseBtn: false, nextButtonAction: { 
            viewModel.send(.gotoLoginView)
        })
    }
}


//#Preview {
//    ResetPasswordView()
//}

//
//  ResetPasswordView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit

public struct ResetPasswordView: View {
    @EnvironmentObject var container: Router
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
            
        }, titleText: "Reset your password",
           nextButtonIsEnabled: viewModel.state.continueButtonIsEnabled,
           hiddenCloseBtn: false,
           nextButtonAction: { viewModel.send(.gotoLoginView) }
        )
    }
}

#Preview {
    ResetPasswordView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            useCase: StubHeyUseCase.stub.onboardingUseCase,
            email: ""
        )
    )
    .environmentObject(Router.default)
}

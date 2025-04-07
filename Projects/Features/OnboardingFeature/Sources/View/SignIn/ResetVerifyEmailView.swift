//
//  EnterEmailView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit

public struct ResetVerifyEmailView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: ResetVerifyEmailViewModel
    
    public init(viewModel: ResetVerifyEmailViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text("Enter your email address and\nwe’ll send you a link to reset your password")
                .font(.regular_16)
                .foregroundColor(.common.SubText.default)
                .padding(.bottom, 32)
            
            HeyTextField(
                text: $viewModel.email,
                placeHolder: "Email",
                textFieldState: $viewModel.state.emailIsValid,
                colorSystem: .gray
            )
            .padding(.bottom, 8)
            
            Text(viewModel.state.errMessage)
                .font(.regular_14)
                .foregroundColor(.heyError)
            
        }, titleText: "Reset your password",
                           nextButtonIsEnabled: viewModel.state.continueButtonIsEnabled,
                           hiddenCloseBtn: false,
                           nextButtonAction: { viewModel.send(.nextButtonDidTap) }
        )
    }
}

import Domain
#Preview {
    ResetVerifyEmailView(viewModel: .init(
        navigationRouter: Router.default.navigationRouter,
        useCase: StubHeyUseCase.stub.signInUseCase
    )
    )
    .preferredColorScheme(.dark)
}

//
//  ResetEnterSecurityCodeView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 3/17/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit

public struct ResetEnterSecurityCodeView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: ResetEnterSecurityCodeViewModel
    
    public init(viewModel: ResetEnterSecurityCodeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text(verbatim: "Enter the 6-digit code we sent to the email:\n\(viewModel.state.hiddenEmail)")
                .font(.regular_16)
                .foregroundColor(.common.SubText.default)
                .lineLimit(2)
            
            Spacer()
                .frame(height: 88)
            
            HStack {
                Spacer()
                SecurityCodeInputView(otpCode: $viewModel.otpCode)
                    .frame(width: 310, height: 50)
                    .padding(.bottom, 16)
                Spacer()
            }
            
            Text(viewModel.state.errMessage)
                .font(.regular_14)
                .foregroundColor(.common.Error.default)
            
        }, titleText: "Enter Your Security Code",
                           nextButtonIsEnabled: viewModel.state.continueButtonIsEnabled,
                           nextButtonAction: { viewModel.send(.nextButtonDidTap) }
        )
    }
}

#Preview {
    EnterSecurityCodeView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            useCase: StubHeyUseCase.stub.signUpUseCase,
            email: "",
            nationality: .Malaysia
        )
    )
    .environmentObject(Router.default)
    .preferredColorScheme(.dark)
}


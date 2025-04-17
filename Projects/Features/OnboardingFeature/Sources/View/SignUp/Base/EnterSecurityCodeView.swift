//
//  EnterSecurityCodeView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit

public struct EnterSecurityCodeView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: EnterSecurityCodeViewModel
    
    public init(viewModel: EnterSecurityCodeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8.adjusted)
            
            Text(verbatim: "Enter the 6-digit code we sent to the email:\n\(viewModel.state.hiddenEmail)")
                .font(.regular_16)
                .foregroundColor(.common.SubText.default)
                .lineLimit(2)
            
            Spacer()
                .frame(height: 88.adjusted)
            
            HStack {
                Spacer()
                VStack {
                    SecurityCodeInputView(otpCode: $viewModel.otpCode)
                        .frame(width: 310, height: 50)
                        .padding(.bottom, 16.adjusted)
                    
                    Text(viewModel.state.errMessage)
                        .font(.regular_14)
                        .foregroundColor(.common.Error.default)
                        .multilineTextAlignment(.center)
                    
                }
                Spacer()
            }
            
            
            
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

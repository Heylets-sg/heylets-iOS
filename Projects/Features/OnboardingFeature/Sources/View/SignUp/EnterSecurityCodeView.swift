//
//  EnterSecurityCodeView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit

public struct EnterSecurityCodeView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: EnterSecurityCodeViewModel
    
    public init(viewModel: EnterSecurityCodeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text(verbatim: "Enter the 6-digit code we sent to the email:\n\(viewModel.state.hiddenEmail)")
                .font(.regular_16)
                .foregroundColor(.heyGray2)
                .lineLimit(2)
            
            Spacer()
                .frame(height: 88)
            
            SecurityCodeInputView(otpCode: $viewModel.otpCode)
            .frame(height: 50)
            
        }, titleText: "Enter Your Security Code", nextButtonIsEnabled: viewModel.state.continueButtonIsEnabled, nextButtonAction: { viewModel.send(.nextButtonDidTap)
        })
    }
}

//#Preview {
//    EnterSecurityCodeView()
//}

//
//  EnterReferralCodeView.swift
//  OnboardingFeatureInterface
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit

public struct EnterReferralCodeView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: EnterReferralCodeViewModel
    
    public init(viewModel: EnterReferralCodeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            Text("You can get 3 timetable themes for free!")
                .font(.regular_16)
                .padding(.bottom, 32)
            
            HeyTextField(
                text: $viewModel.referralCode,
                placeHolder: "enter referral code ex) 12345",
                textFieldState: $viewModel.state.referralIsValid,
                colorSystem: .gray
            )
            .maxLength(text: $viewModel.referralCode, 6)
            .padding(.bottom, 8)
            
            Text(viewModel.state.referralMessage)
                .font(.regular_12)
                .foregroundColor(viewModel.state.referralIsValid.strokeColor)
            
        }, titleText: "Enter a referral code to unlock\nmore features🎉",
        buttonTitle : "Start Heylets",
        nextButtonAction: { viewModel.send(.nextButtonDidTap) }
        )
    }
}

#Preview {
    EnterReferralCodeView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            useCase: StubHeyUseCase.stub.signUpUseCase
        )
    )
    .environmentObject(Router.default)
}


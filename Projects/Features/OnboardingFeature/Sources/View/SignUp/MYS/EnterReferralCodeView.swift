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
            
            
        }, titleText: "Enter a referral code to unlock\nmore features🎉",
        nextButtonIsEnabled: viewModel.state.continueButtonIsEnabled,
        nextButtonAction: { viewModel.send(.nextButtonDidTap) }
        )
    }
}

fileprivate struct GenderButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .font(.semibold_14)
                .background(isSelected ? Color.heyMain : Color.heyGray4)
                .foregroundStyle(isSelected ? Color.heyGray1 : Color.heyGray2)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
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


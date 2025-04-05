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
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 92.adjusted)
                
                HStack {
                    Button {
                        viewModel.send(.backButtonDidTap)
                    } label: {
                        Image(uiImage: .icBack)
                            .resizable()
                            .frame(width: 22.adjusted, height: 18.adjusted)
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.send(.skipButtonDidTap)
                    } label: {
                        Text("Skip")
                            .font(.regular_16)
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Enter a referral code to unlock\nmore features🎉")
                        .font(.semibold_18)
                        .foregroundColor(.heyGray1)
                        .padding(.bottom, 18.adjusted)
                    
                    Spacer()
                        .frame(height: 8.adjusted)
                    
                    Text("You can get 3 timetable themes for free!")
                        .font(.regular_16)
                        .padding(.bottom, 32.adjusted)
                    
                    HeyTextField(
                        text: $viewModel.referralCode,
                        placeHolder: "enter referral code ex) 12345",
                        textFieldState: $viewModel.state.referralIsValid,
                        colorSystem: .gray
                    )
                    .maxLength(text: $viewModel.referralCode, 6)
                    .padding(.bottom, 8.adjusted)
                    
                    Text(viewModel.state.referralMessage)
                        .font(.regular_12)
                        .foregroundColor(viewModel.state.referralIsValid.strokeColor)
                    
                    Spacer()
                    
                    Button("Start Heylets") {
                        viewModel.send(.nextButtonDidTap)
                    }
                    .heyBottomButtonStyle()
                    
                }
                .padding(.top, 36.adjusted)
                .padding(.bottom, 65.adjusted)
            }
            .padding(.horizontal, 16)
            .background(Color.heyWhite)
            .ignoresSafeArea(edges: .vertical)
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden()
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


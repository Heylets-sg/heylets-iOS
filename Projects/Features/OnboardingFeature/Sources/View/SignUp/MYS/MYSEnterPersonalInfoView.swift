//
//  MYSEnterPersonalInfoView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 3/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit

public struct MYSEnterPersonalInfoView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: MYSEnterPersonalInfoViewModel
    
    @State var date = Date()
    @State var showPassword = false
    
    public init(viewModel: MYSEnterPersonalInfoViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 16)
            
            VStack(spacing: 16) {
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
            
            Spacer()
                .frame(height: 40)
            
            HStack(spacing: 16) {
                ForEach(Gender.allCases, id: \.self) { gender in
                    GenderButton(
                        title: gender.title,
                        isSelected: gender == viewModel.gender,
                        action: { viewModel.send(.genderButtonDidTap(gender)) }
                    )
                }
            }
            .padding(.trailing, 62)
            .padding(.bottom, 20)
            
            HStack {
                DatePicker(
                    "DatePicker",
                    selection: $viewModel.birth,
                    displayedComponents: [.date]
                )
                .onChange(of: viewModel.birth) { date in
                    viewModel.send(.birthDayDidChange(date))
                }
                .labelsHidden()
            }
        }, titleText: "Please enter your account\ninformation!",
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
    MYSEnterPersonalInfoView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            useCase: StubHeyUseCase.stub.signUpUseCase
        )
    )
    .environmentObject(Router.default)
}

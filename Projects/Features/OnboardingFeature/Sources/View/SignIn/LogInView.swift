//
//  LogInView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit

public struct LogInView: View {
    @EnvironmentObject var container: DIContainer
    @ObservedObject var viewModel: LogInViewModel
    
    @State var showPassword: Bool = false
    
    public init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(alignment: .trailing) {
            Image(uiImage: .logo)
                .resizable()
                .frame(height: 56)
                .padding(.horizontal, 125)
                .padding(.bottom, 32)
            
            HStack {
                Text("Log In")
                    .font(.semibold_18)
                    .foregroundStyle(Color.heyGray1)
                
                Spacer()
                
                Text("New to Heylets?")
                    .font(.regular_14)
                    .foregroundStyle(Color.heyGray1)
                    .padding(.trailing, 8)
                
                Button {
                    viewModel.send(.signUpButtonDidTap)
                } label: {
                    Text("Sign Up")
                        .font(.regular_12)
                        .foregroundStyle(Color.heyMain)
                }
            }
            .padding(.bottom, 29)
            
            HeyTextField(
                text: $viewModel.id,
                placeHolder: "ID"
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.heyGray3, lineWidth: 1)
            )
            .padding(.bottom, 21)
            
            PasswordField(
                password: $viewModel.password,
                showPassword: $showPassword, colorSystem: .white
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.heyGray3, lineWidth: 1)
            )
            .padding(.bottom, 14)
            
            Button {
                viewModel.send(.forgotPasswordButtonDidTap)
            } label: {
                Text("Forgot password?")
                    .font(.regular_12)
                    .foregroundStyle(Color.heyGray1)
            }
            
            Spacer()
            
            Button("Log In") {
                viewModel.send(.loginButtonDidTap)
            }
//            .disabled(!viewModel.state.loginButtonEnabled)
            .heyBottomButtonStyle()
        }
        .padding(.top, 106)
        .padding(.bottom, 65)
        .padding(.horizontal, 16)
        .background(Color.heyWhite)
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
        .setOnboardingHeyNavigation()
//        .setOnboardingNavigation()
    }
}

//#Preview {
//    LogInView()
//}

//
//  LogInView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit

public struct LogInView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: LogInViewModel
    
    @State var showPassword: Bool = false
    @FocusState var isFocused: Field?
    
    enum Field {
        case id
        case password
    }
    
    public init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack(path: $container.navigationRouter.destinations) {
            VStack(alignment: .trailing) {
                HStack {
                    Spacer()
                    Button {
                        viewModel.send(.closeButtonDidTap)
                    } label: {
                        Image(uiImage: .icClose)
                            .resizable()
                            .frame(width: 18, height: 18)
                    }
                    .hidden(!viewModel.state.showCloseBtn)
                }
                .padding(.bottom, 10.adjusted)
                
                Image(uiImage: .logo)
                    .resizable()
                    .frame(height: 56)
                    .padding(.horizontal, 125)
                    .padding(.bottom, 32.adjusted)
                
                HStack {
                    Text("Log In")
                        .font(.semibold_18)
                        .foregroundColor(.common.MainText.default)
                    
                    Spacer()
                    
                    Text("New to Heylets?")
                        .font(.regular_14)
                        .foregroundColor(.common.GuideText.default)
                        .padding(.trailing, 8)
                    
                    Button {
                        viewModel.send(.signUpButtonDidTap)
                    } label: {
                        Text("Sign Up")
                            .font(.regular_12)
                            .foregroundColor(.common.MainText.default)
                    }
                }
                .padding(.bottom, 29.adjusted)
                
                HeyTextField(
                    text: $viewModel.id,
                    placeHolder: "ID"
                )
                .focused($isFocused, equals: .id)
                .padding(.bottom, 21.adjusted)
                
                PasswordField(
                    password: $viewModel.password,
                    showPassword: $showPassword, 
                    colorSystem: .white
                )
                .focused($isFocused, equals: .password)
                .padding(.bottom, 14)
                
                HStack {
                    Text(viewModel.state.errMessage)
                        .font(.regular_14)
                        .foregroundColor(.common.Error.default)
                        .frame(width: 180)
                    
                    Spacer()
                    
                    Button {
                        viewModel.send(.forgotPasswordButtonDidTap)
                    } label: {
                        Text("Forgot password?")
                            .font(.regular_12)
                            .foregroundColor(.common.Placeholder.default)
                    }
                }
                
                Spacer()
                
                Button("Log In") {
                    viewModel.send(.loginButtonDidTap)
                }
                .heyCTAButtonStyle()
            }
            .onSubmit {
                switch isFocused {
                case .id:
                    isFocused = .password
                default:
                    isFocused = nil
                }
            }
            .onAppear {
                viewModel.send(.onAppear)
            }
            .padding(.top, 106.adjusted)
            .padding(.bottom, 65.adjusted)
            .padding(.horizontal, 16)
            .background(Color.common.Background.default)
            .ignoresSafeArea(edges: .vertical)
            .ignoresSafeArea(.keyboard)
            .navigationBarBackButtonHidden()
            .onTapGesture {
                isFocused = nil
            }
            .loading(viewModel.state.isLoading)
            .setOnboardingHeyNavigation()
        }
    }
}

#Preview {
    LogInView(
        viewModel: .init(
            navigationRouter: Router.default.navigationRouter,
            windowRouter: Router.default.windowRouter,
            useCase: StubHeyUseCase.stub.signInUseCase
        )
    )
    .environmentObject(Router.default)
    .preferredColorScheme(.dark)
}

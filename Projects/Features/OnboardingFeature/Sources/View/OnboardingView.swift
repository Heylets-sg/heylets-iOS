//
//  OnboardingView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency
import Core

public struct OnboardingView: View {
    @EnvironmentObject var onboardingRouter: OnboardingNavigationRouter
    var viewModel: OnboardingViewModel
    
    public init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack(path: $onboardingRouter.destinations) {
            VStack {
                Button {
                    viewModel.send(.signUpButtonDidTap)
                } label: {
                    Text("SignUp")
                }
                
                Spacer()
                    .frame(height: 50)
                
                Button {
                    viewModel.send(.signInButtonDidTap)
                } label: {
                    Text("SignIn")
                }
            }
            .setHeyNavigation()
        }
    }
}



//#Preview {
//    OnboardingView()
//}



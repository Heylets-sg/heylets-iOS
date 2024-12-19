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
    @EnvironmentObject var router: Router
    var viewModel: OnboardingViewModel
    
    public init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        NavigationStack(path: $router.navigationRouter.destinations) {
            VStack {
                Button {
                    viewModel.send(.loginButtonDidTap)
                } label: {
                    Text("login")
                }
                
                Spacer()
                    .frame(height: 50)
                
                Button {
                    viewModel.send(.resetButtonDidTap)
                } label: {
                    Text("login")
                }
            }
        }
    }
}



//#Preview {
//    OnboardingView()
//}


public class OnboardingViewModel: ObservableObject {
    
    enum Action {
        case loginButtonDidTap
        case resetButtonDidTap
    }
    
    public var navigationRouter: NavigationRoutableType
    
    public init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
        print(navigationRouter.destinations)
    }
    
    func send(_ action: Action) {
        switch action {
        case .loginButtonDidTap:
            print("버튼 클릭")
            navigationRouter.push(to: .login)
        case .resetButtonDidTap:
            navigationRouter.push(to: .resetPasswordView)
        }
    }
}

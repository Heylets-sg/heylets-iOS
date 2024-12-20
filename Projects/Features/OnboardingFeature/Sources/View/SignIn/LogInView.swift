//
//  LogInView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct LogInView: View {
    @EnvironmentObject var router: Router
    var viewModel: LogInViewModel
    
    public init(viewModel: LogInViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        VStack {
            Button {
                viewModel.send(.loginButtonDidTap)
            } label: {
                Text("LogIn")
            }
            
            Spacer()
                .frame(height: 50)
            
            Button {
                viewModel.send(.forgotPasswordButtonDidTap)
            } label: {
                Text("forget password")
            }
        }
    }
}

//#Preview {
//    LogInView()
//}

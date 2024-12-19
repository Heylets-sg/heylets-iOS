//
//  EnterSecurityCodeView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct EnterSecurityCodeView: View {
    @EnvironmentObject var router: Router
    var viewModel: EnterSecurityCodeViewModel
    
    public init(viewModel: EnterSecurityCodeViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Button {
            viewModel.send(.backButtonDidTap)
        } label: {
            Text("BackButton")
        }
        
        Spacer()
            .frame(height: 50)
        
        Button {
            viewModel.send(.nextButtonDidTap)
        } label: {
            Text("Continue")
        }
    }
}

//#Preview {
//    EnterSecurityCodeView()
//}

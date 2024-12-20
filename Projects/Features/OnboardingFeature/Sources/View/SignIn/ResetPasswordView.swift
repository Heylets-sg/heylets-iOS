//
//  ResetPasswordView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct ResetPasswordView: View {
    @EnvironmentObject var router: Router
    var viewModel: ResetPasswordViewModel
    
    public init(viewModel: ResetPasswordViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        Text("ResetPasswordView")
    }
}

//#Preview {
//    ResetPasswordView()
//}

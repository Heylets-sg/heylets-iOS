//
//  VerifyEmailView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct VerifyEmailView: View {
    @EnvironmentObject var router: Router
    var viewModel: VerifyEmailViewModel
    
    public init(viewModel: VerifyEmailViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("VerifyEmailView")
    }
}

//#Preview {
//    VerifyEmailView()
//}

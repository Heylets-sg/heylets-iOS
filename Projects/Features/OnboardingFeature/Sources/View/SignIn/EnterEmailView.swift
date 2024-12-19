//
//  EnterEmailView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct EnterEmailView: View {
    @EnvironmentObject var router: Router
    var viewModel: EnterEmailViewModel
    
    public init(viewModel: EnterEmailViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        Text("EnterEmailView")
    }
}

//#Preview {
//    EnterEmailView()
//}

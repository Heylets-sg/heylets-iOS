//
//  AddProfileVIew.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct AddProfileView: View {
    @EnvironmentObject var router: Router
    var viewModel: AddProfileViewModel
    
    public init(viewModel: AddProfileViewModel) {
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
//    AddProfileView()
//}

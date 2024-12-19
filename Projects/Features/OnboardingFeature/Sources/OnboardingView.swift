//
//  OnboardingView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct OnboardingView: View {
    private var navigationRouter: NavigationRoutableType
    
    public init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
    }
    
    public var body: some View {
        VStack {
            Button {
                navigationRouter.push(to: .mypage)
            } label: {
                Text("OnboardingView")
            }
        }
    }
}

//#Preview {
//    OnboardingView()
//}

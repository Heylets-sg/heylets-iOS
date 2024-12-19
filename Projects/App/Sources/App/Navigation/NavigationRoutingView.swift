//
//  NavigationRoutingView.swift
//  Heylets-iOS
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//


import Foundation
import SwiftUI

import BaseFeatureDependency
import MyPageFeature
import OnboardingFeature
import TimeTableFeature

import Core

struct NavigationRoutingView: View {
    
    @EnvironmentObject var router: Router
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        case .mypage:
            MyPageView()
                .setHeyNavigation()
        case .timetable:
            TimeTableView()
                .setHeyNavigation()
        case .onboarding:
            OnboardingView(viewModel: .init(navigationRouter: router.navigationRouter))
                .setHeyNavigation()
        case .login:
            LogInView()
        case .resetPasswordView:
            ResetPasswordView()
        }
    }
}


extension View {
    func setHeyNavigation() -> some View {
        self.navigationDestination(for: NavigationDestination.self) { destination in
            return NavigationRoutingView(destination: destination)
        }
    }
}

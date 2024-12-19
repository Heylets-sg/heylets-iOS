//
//  Router+View.swift
//  RootFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import BaseFeatureDependency
import MyPageFeature
import TimeTableFeature
import OnboardingFeature

import SwiftUI

extension NavigationDestination {
    @ViewBuilder
    func view(navigationRouter: NavigationRouter) -> some View {
        switch self {
        case .mypage:
            MyPageView()
        case .onboarding:
            OnboardingView(navigationRouter: navigationRouter)
        case .timetable:
            TimeTableView()
        }
    }
}


extension View {
    func setHeyNavigation() -> some View {
        self.navigationDestination(for: NavigationDestination.self) { destination in
            destination.view(navigationRouter: <#NavigationRouter#>)
        }
    }
}

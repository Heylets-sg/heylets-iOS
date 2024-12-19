//
//  example.swift
//  RootFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency
import OnboardingFeature
import TimeTableFeature
import MyPageFeature
import SplashFeature

public struct RootView: View {
    public init() {}
    @EnvironmentObject var router: Router 
    
    public var body: some View {
        Group {
            switch router.windowRouter.destination {
            case .splash:
                SplashView()
            case .onboarding:
                OnboardingView(
                    viewModel: OnboardingViewModel(
                        navigationRouter: router.navigationRouter
                    )
                )
            case .timetable:
                TimeTableView()
            case .mypage:
                MyPageView()
            }
        }
    }
    
    var splashView: some View {
        VStack {
            Text("Splash View")
        }
    }
}


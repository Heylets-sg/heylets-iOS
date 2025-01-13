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
    @EnvironmentObject var container: DIContainer

    public var body: some View {
        Group {
            switch container.windowRouter.destination {
            case .splash:
                SplashView(
                    viewModel: .init(windowRouter: container.windowRouter)
                )
            case .onboarding:
                OnboardingView(
                    viewModel: OnboardingViewModel(
                        navigationRouter: container.navigationRouter
                    )
                )
            case .timetable:
                TimeTableView(
                    viewModel: .init(),
                    searchModuleViewModel: .init(),
                    addCustomModuleViewModel: .init(),
                    settingTimeTableViewModel: .init(),
                    themeViewModel: .init()
                )
            case .mypage:
                MyPageView(
                    viewModel: MyPageViewModel(
                        navigationRouter: container.navigationRouter,
                        windowRouter: container.windowRouter
                    )
                )
            }
            
        }
    }
    
    var splashView: some View {
        VStack {
            Text("Splash View")
        }
    }
}

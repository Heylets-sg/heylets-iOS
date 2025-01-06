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

public class HeyNavigationRouter: ObservableObject {
    public init() {}
    let onboarding = OnboardingNavigationRouter()
    let myPage = MyPageNavigationRouter()
}

public struct RootView: View {
    public init() {}
    @EnvironmentObject var router: Router
    @EnvironmentObject var navigationRouter: HeyNavigationRouter
    
    public var body: some View {
        Group {
            switch router.windowRouter.destination {
            case .splash:
                SplashView(viewModel: .init(windowRouter: router.windowRouter))
            case .onboarding:
                OnboardingView(
                    viewModel: OnboardingViewModel(
                        navigationRouter: navigationRouter.onboarding
                    )
                )
                .environmentObject(navigationRouter.onboarding)
            case .timetable:
                TimeTableView(
                    viewModel: .init(),
                    searchModuleViewModel: .init(),
                    addCustomModuleViewModel: .init()
                )
            case .mypage:
                MyPageView(
                    viewModel: MyPageViewModel(
                        navigationRouter: navigationRouter.myPage,
                        windowRouter: router.windowRouter
                    )
                )
                .environmentObject(navigationRouter.myPage)
            }
            
        }
    }
    
    var splashView: some View {
        VStack {
            Text("Splash View")
        }
    }
}

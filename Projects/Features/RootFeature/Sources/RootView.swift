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
import Domain

public struct RootView: View {
    public init() {}
    @EnvironmentObject var router: Router
    @EnvironmentObject var useCase: HeyUseCase
    
    public var body: some View {
        Group {
            switch router.windowRouter.destination {
            case .splash:
                SplashView(
                    viewModel: .init(windowRouter: router.windowRouter)
                )
            case .onboarding:
                AddProfileView(viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.onboardingUseCase
                    )
                )
                //                OnboardingView(
                //                    viewModel: OnboardingViewModel(
                //                        navigationRouter: router.navigationRouter
                //                    )
                //                )
            case .timetable:
                TimeTableView(
                    viewModel: .init(
                        useCase: useCase.timeTableUseCase
                    ),
                    searchModuleViewModel: .init(
                        useCase: useCase.timeTableUseCase
                    ),
                    addCustomModuleViewModel: .init(
                        useCase: useCase.timeTableUseCase
                    ),
                    settingTimeTableViewModel: .init(),
                    themeViewModel: .init(
                        useCase: useCase.timeTableUseCase
                    )
                )
            case .mypage:
                MyPageView(
                    viewModel: MyPageViewModel(
                        navigationRouter: router.navigationRouter,
                        windowRouter: router.windowRouter,
                        useCase: useCase.myPageUseCase
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

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
                    viewModel: .init(
                        windowRouter: router.windowRouter, 
                        useCase: useCase.splashUseCase
                    )
                )
            case .onboarding:
                OnboardingView(
                    viewModel: OnboardingViewModel(
                        navigationRouter: router.navigationRouter
                    )
                )
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
            case .mypage(let profileInfo):
                MyPageView(
                    viewModel: MyPageViewModel(
                        navigationRouter: router.navigationRouter,
                        windowRouter: router.windowRouter,
                        useCase: useCase.myPageUseCase,
                        profileInfo: profileInfo
                    )
                )
            }
            
        }
    }
}

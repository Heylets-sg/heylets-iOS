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
import TodoFeature
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
            case .login:
                LogInView(viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    windowRouter: router.windowRouter,
                    useCase: useCase.signInUseCase
                )
                )
            case .timetable:
                let useCase = useCase.timeTableUseCase
                TimeTableView(
                    viewModel: .init(
                        SearchModuleViewModel(useCase),
                        AddCustomModuleViewModel(useCase),
                        ThemeViewModel(useCase, router.navigationRouter),
                        TimeTableSettingViewModel(useCase),
                        router.navigationRouter,
                        router.windowRouter,
                        useCase
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
            case .todo:
                let useCase = useCase.todoUseCase
                TodoView(
                    viewModel: TodoViewModel(
                        windowRouter: router.windowRouter,
                        useCase: useCase
                    )
                )
            }
        }
    }
}

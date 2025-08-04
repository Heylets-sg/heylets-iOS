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
                LogInView(
                    viewModel: .init(
                    router.navigationRouter,
                    router.windowRouter,
                    useCase.signInUseCase
                    )
                )
            case .timetable:
                let presentCoordinator = TimeTableCoordinator.default.presentCoordinator
                let sheetCoordinator = TimeTableCoordinator.default.sheetCoordinator
                let timeTableState = TimeTableState.default
                TimeTableView(
                    state: timeTableState,
                    viewModel: .init(
                        TimeTableSettingViewModel(useCase.settingUseCase),
                        useCase.timeTableStore,
                        timeTableState,
                        useCase.mainUseCase,
                        router.windowRouter,
                        router.navigationRouter,
                        presentCoordinator,
                        sheetCoordinator
                    ),
                    searchViewModel: .init(
                        useCase.searchUseCase,
                        timeTableState,
                        presentCoordinator
                    ),
                    themeViewModel: .init(
                        useCase.settingUseCase,
                        useCase.timeTableStore,
                        router.navigationRouter
                    ),
                    addCustomViewModel: .init(
                        useCase.searchUseCase,
                        presentCoordinator
                    )
                )
                .environmentObject(TimeTableCoordinator.default)
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

//
//  ViewFactory.swift
//  RootFeature
//
//  Created by 류희재 on 8/4/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import OnboardingFeature
import TimeTableFeature
import MyPageFeature
import SplashFeature
import TodoFeature
import Domain

@MainActor
protocol ViewFactoryType {
    associatedtype ViewType: View
    func create() -> ViewType
}

@MainActor
class BaseViewFactory {
    let router: Router
    let useCase: HeyUseCase
    
    init(router: Router, useCase: HeyUseCase) {
        self.router = router
        self.useCase = useCase
    }
}

@MainActor
class SplashViewFactory: BaseViewFactory, ViewFactoryType {
    func create() -> SplashView {
        return SplashView(
            viewModel: .init(
                windowRouter: router.windowRouter,
                useCase: useCase.splashUseCase
            )
        )
    }
}

@MainActor
class OnboardingViewFactory: BaseViewFactory, ViewFactoryType {
    func create() -> OnboardingView {
        return OnboardingView(
            viewModel: OnboardingViewModel(
                navigationRouter: router.navigationRouter
            )
        )
    }
}

@MainActor
class LoginViewFactory: BaseViewFactory, ViewFactoryType {
    func create() -> LogInView {
        return LogInView(
            viewModel: .init(
                router.navigationRouter,
                router.windowRouter,
                useCase.signInUseCase
            )
        )
    }
}

@MainActor
class TimeTableViewFactory: BaseViewFactory, ViewFactoryType {
    func create() -> some View {
        let presentCoordinator = TimeTableCoordinator.default.presentCoordinator
        let sheetCoordinator = TimeTableCoordinator.default.sheetCoordinator
        let timeTableState = TimeTableState.default
        
        return TimeTableView(
            state: timeTableState,
            viewModel: .init(
                AddCustomModuleViewModel(useCase.searchUseCase, presentCoordinator),
                SettingViewModel(useCase.settingUseCase),
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
                timeTableState,
                useCase.settingUseCase,
                useCase.timeTableStore,
                router.navigationRouter
            )
        )
        .environmentObject(TimeTableCoordinator.default)
    }
}

@MainActor
class MyPageViewFactory: BaseViewFactory, ViewFactoryType {
    func create() -> MyPageView {
        return MyPageView(
            viewModel: MyPageViewModel(
                navigationRouter: router.navigationRouter,
                windowRouter: router.windowRouter,
                useCase: useCase.myPageUseCase
            )
        )
    }
}

@MainActor
class TodoViewFactory: BaseViewFactory, ViewFactoryType {
    func create() -> TodoView {
        return TodoView(
            viewModel: TodoViewModel(
                windowRouter: router.windowRouter,
                useCase: useCase.todoUseCase
            )
        )
    }
}

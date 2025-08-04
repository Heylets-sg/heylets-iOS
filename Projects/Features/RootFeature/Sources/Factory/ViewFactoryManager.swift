//
//  ViewFactoryManager.swift
//  RootFeature
//
//  Created by 류희재 on 8/4/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import Domain

@MainActor
class ViewFactoryManager {
    private let router: Router
    private let useCase: HeyUseCase
    
    private lazy var splashFactory = SplashViewFactory(router: router, useCase: useCase)
    private lazy var onboardingFactory = OnboardingViewFactory(router: router, useCase: useCase)
    private lazy var loginFactory = LoginViewFactory(router: router, useCase: useCase)
    private lazy var timeTableFactory = TimeTableViewFactory(router: router, useCase: useCase)
    private lazy var myPageFactory = MyPageViewFactory(router: router, useCase: useCase)
    private lazy var todoFactory = TodoViewFactory(router: router, useCase: useCase)
    
    init(router: Router, useCase: HeyUseCase) {
        self.router = router
        self.useCase = useCase
    }
    
    @ViewBuilder
    func createView(for destination: WindowDestination) -> some View {
        switch destination {
        case .splash:
            splashFactory.create()
        case .onboarding:
            onboardingFactory.create()
        case .login:
            loginFactory.create()
        case .timetable:
            timeTableFactory.create()
        case .mypage:
            myPageFactory.create()
        case .todo:
            todoFactory.create()
        }
    }
}

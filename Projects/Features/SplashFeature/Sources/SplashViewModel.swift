//
//  SplashViewModel.swift
//  SplashFeature
//
//  Created by 류희재 on 12/20/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import Core

public class SplashViewModel: ObservableObject {
    
    enum Action {
        case onAppear
        case goToOnboarding
        case goToMyPage
        case goToTimeTable
    }
    
    public var windowRouter: WindowRoutable
    private var cancelBag = CancelBag()
    var useCase: SplashUseCaseType
    
    public init(
        windowRouter: WindowRoutableType,
        useCase: SplashUseCaseType
    ) {
        self.windowRouter = windowRouter
        self.useCase = useCase
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.autoLogin()
                .sink(receiveValue: {[weak self] tokenExisted in
                    if tokenExisted {
                        self?.windowRouter.switch(to: .timetable)
                    } else {
                        self?.windowRouter.switch(to: .onboarding)
                    }
                })
                .store(in: cancelBag)
//                .flatMap { tokenExisted -> AnyPublisher<Void, Never> in
//                    if tokenExisted {
//                        return Just(()).eraseToAnyPublisher()
//                    } else {
//                        return self.useCase.tokenRefresh()
//                    }
//                }
//                .sink(receiveValue: { [weak self] in
//                    self?.windowRouter.switch(to: .timetable)
//                })
//                .store(in: cancelBag)
        case .goToOnboarding:
            windowRouter.switch(to: .onboarding)
        case .goToMyPage:
            windowRouter.switch(to: .mypage)
        case .goToTimeTable:
            windowRouter.switch(to: .timetable)
        }
    }
}



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

public class SplashViewModel: ObservableObject {
    
    enum Action {
        case goToOnboarding
        case goToMyPage
        case goToTimeTable
    }
    
    public var windowRouter: WindowRoutable
    
    public init(windowRouter: WindowRoutableType) {
        self.windowRouter = windowRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case .goToOnboarding:
            windowRouter.switch(to: .onboarding)
        case .goToMyPage:
            windowRouter.switch(to: .mypage)
        case .goToTimeTable:
            windowRouter.switch(to: .timetable)
        }
    }
}



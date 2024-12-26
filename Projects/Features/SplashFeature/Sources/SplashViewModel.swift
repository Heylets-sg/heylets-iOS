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

public class SplashViewModel: ObservableObject {
    
    enum Action {
        case goToOnboarding
        case goToMyPage
    }
    
    public var windowRouter: WindowRoutable
    
    public init(windowRouter: WindowRoutable) {
        self.windowRouter = windowRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case .goToOnboarding:
            windowRouter.switch(to: .onboarding)
        case .goToMyPage:
            windowRouter.switch(to: .mypage)
        }
    }
}



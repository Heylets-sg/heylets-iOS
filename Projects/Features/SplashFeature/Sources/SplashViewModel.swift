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
        case buttonDidTap
    }
    
    public var windowRouter: WindowRoutable
    
    public init(windowRouter: WindowRoutable) {
        self.windowRouter = windowRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case .buttonDidTap:
            windowRouter.switch(to: .onboarding)
        }
    }
}



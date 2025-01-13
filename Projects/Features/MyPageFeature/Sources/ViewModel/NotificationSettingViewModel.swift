//
//  NotificationSettingViewModel.swift
//  MyPageFeature
//
//  Created by 류희재 on 1/2/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency

public class NotificationSettingViewModel: ObservableObject {
    struct State {
        var dailyBriefingToggleOn: Bool = false
        var classToggleOn: Bool = false
    }
    
    enum Action {
        case backButtonDidTap
        case dailyBriefingToggleDidTap
        case classToggleDidTap
    }
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    
    public init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .dailyBriefingToggleDidTap:
            state.dailyBriefingToggleOn.toggle()
        case .classToggleDidTap:
            state.classToggleOn.toggle()
        }
    }
}

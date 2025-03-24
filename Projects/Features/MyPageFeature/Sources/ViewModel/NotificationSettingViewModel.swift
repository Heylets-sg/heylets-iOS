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
import Domain
import Core

public class NotificationSettingViewModel: ObservableObject {
    struct State {
        var dailyBriefingToggleOn: Bool = false
        var classToggleOn: Bool = false
    }
    
    enum Action {
        case onAppear
        case backButtonDidTap
        case dailyBriefingToggleDidTap
        case classToggleDidTap
    }
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private let useCase: MyPageUseCaseType
    private var cancelBag = CancelBag()
    
    public init(
        useCase: MyPageUseCaseType,
        navigationRouter: NavigationRoutableType
    ) {
        self.useCase = useCase
        self.navigationRouter = navigationRouter
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getNotificationSettingInfo()
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] settingInfo in
                    self?.state.dailyBriefingToggleOn = settingInfo.dailyBriefing.isEnabled
                    self?.state.classToggleOn = settingInfo.classNotification.isEnabled
                })
                .store(in: cancelBag)
        case .backButtonDidTap:
            navigationRouter.pop()
        case .dailyBriefingToggleDidTap:
            state.dailyBriefingToggleOn.toggle()
        case .classToggleDidTap:
            state.classToggleOn.toggle()
        }
    }
}

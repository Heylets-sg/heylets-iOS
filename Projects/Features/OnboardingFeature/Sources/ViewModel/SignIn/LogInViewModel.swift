//
//  LogInViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Core

public class LogInViewModel: ObservableObject {
    
    enum Action {
        case loginButtonDidTap
        case forgotPasswordButtonDidTap
        case signUpButtonDidTap
    }
    
    struct State {
        var loginButtonEnabled = false
    }
    
    @Published var state = State()
    @Published var id: String = ""
    @Published var password: String = ""
    private let cancelBag = CancelBag()
    
    public var navigationRouter: OnboardingNavigationRouter
    public var windowRouter: WindowRoutableType
    
    public init(
        navigationRouter: OnboardingNavigationRouter,
        windowRouter: WindowRoutableType
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .loginButtonDidTap:
            //TODO: 비밀번호, ID 유효성 처리
            //TODO: 로그인 API 연결
            windowRouter.switch(to: .timetable)
        case .forgotPasswordButtonDidTap:
            navigationRouter.push(to: .enterEmail)
        case .signUpButtonDidTap:
            navigationRouter.push(to: .selectUniversity)
        }
    }
    
    func observe() {
        print(id, id.isEmpty)
        print(password, password.isEmpty)
        weak var owner = self
        guard let owner else { return }
        
        Publishers.CombineLatest($id, $password)
            .map { !$0.isEmpty && !$1.isEmpty }
            .assign(to: \.state.loginButtonEnabled, on: owner)
            .store(in: cancelBag)
    }
}


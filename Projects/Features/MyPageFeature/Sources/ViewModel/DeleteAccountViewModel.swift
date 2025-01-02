//
//  DeleteAccountViewModel.swift
//  MyPageFeature
//
//  Created by 류희재 on 1/2/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import DSKit
import Core

public class DeleteAccountViewModel: ObservableObject {
    struct State {
        var deleteAccountButtonDidTap: Bool = false
        var deleteAccountAlertViewIsPresented: Bool = false
        var inValidPasswordAlertViewIsPresented: Bool = false
    }
    
    enum Action {
        case backButtonDidTap
        case deleteAccountButtonDidTap
        case dismissDeleteAccountAlertView
        case dismissInValidPasswordAlertView
        case deleteAccount
    }
    
    public var navigationRouter: MyPageNavigationRouter
    public var windowRouter: WindowRoutableType
    private let cancelBag = CancelBag()
    
    @Published var state = State()
    @Published var password = ""
    
    public init(
        navigationRouter: MyPageNavigationRouter,
        windowRouter: WindowRoutableType
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .deleteAccountButtonDidTap:
            state.deleteAccountAlertViewIsPresented = true
        case .dismissDeleteAccountAlertView:
            state.deleteAccountAlertViewIsPresented = false
        case .deleteAccount:
            //TODO: 회원탈퇴 API 구현
            
            //TODO: 안되면 alert창 (invalid 뭐시기~)
            
            //TODO: 성공하면 온보딩으로
            windowRouter.switch(to: .onboarding)
        case .dismissInValidPasswordAlertView:
            state.inValidPasswordAlertViewIsPresented = false
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $password
            .map { !$0.isEmpty}
            .assign(to: \.state.deleteAccountButtonDidTap, on: owner)
            .store(in: cancelBag)
        
    }
}

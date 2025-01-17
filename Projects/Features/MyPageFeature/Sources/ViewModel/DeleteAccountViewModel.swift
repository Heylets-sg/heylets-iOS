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
import Domain
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
    
    private let useCase: MyPageUseCaseType
    public var navigationRouter: NavigationRoutableType
    public var windowRouter: WindowRoutableType
    private let cancelBag = CancelBag()
    
    @Published var state = State()
    @Published var password = ""
    
    public init(
        navigationRouter: NavigationRoutableType,
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
            useCase.deleteAccount(password)
                //TODO: 실패처리
                .sink(receiveValue: { [weak self] _ in
                    self?.windowRouter.switch(to: .onboarding)
                })
                .store(in: cancelBag)
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

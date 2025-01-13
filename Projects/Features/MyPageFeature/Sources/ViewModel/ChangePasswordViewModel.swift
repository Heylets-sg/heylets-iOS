//
//  ChangePasswordViewModel.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import DSKit
import Core

public class ChangePasswordViewModel: ObservableObject {
    struct State {
        var newPasswordIsValid: TextFieldState = .idle
        var checkPasswordIsValid: TextFieldState = .idle
        var changePasswordButtonIsEnabled: Bool = false
        var changePasswordAlertViewIsPresented: Bool = false
    }
    
    enum Action {
        case backButtonDidTap
        case changePasswordButtonDidTap
        case dismissAlertView
    }
    
    public var navigationRouter: NavigationRoutableType
    private let cancelBag = CancelBag()
    
    @Published var state = State()
    @Published var currentPassword = ""
    @Published var newPassword = ""
    @Published var checkPassword = ""
    
    public init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .changePasswordButtonDidTap:
            //TODO: 비밀번호 Reset API 구현
            
            //TODO: 안되면 alert창
            
            //TODO: 성공하면 pop
            navigationRouter.pop()
        case .dismissAlertView:
            state.changePasswordAlertViewIsPresented = true
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $newPassword
            .map { $0.isEmpty ? .idle : ($0.isValidPassword() ? .valid : .invalid) }
            .assign(to: \.state.newPasswordIsValid, on: owner)
            .store(in: cancelBag)
        
        $checkPassword
            .map { $0.isEmpty ? .idle : ($0 == owner.newPassword ? .valid : .invalid) }
            .assign(to: \.state.checkPasswordIsValid, on: owner)
            .store(in: cancelBag)
        
        Publishers.CombineLatest3($currentPassword, $newPassword, $checkPassword)
            .map { _ in
                owner.state.newPasswordIsValid == .valid &&
                owner.state.checkPasswordIsValid == .valid &&
                !owner.currentPassword.isEmpty
            }
            .assign(to: \.state.changePasswordButtonIsEnabled, on: owner)
            .store(in: cancelBag)
        
    }
}


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
import Domain
import DSKit
import Core

public class ChangePasswordViewModel: ObservableObject {
    struct State {
        var newPasswordIsValid: TextFieldState = .idle
        var checkPasswordIsValid: TextFieldState = .idle
        var changePasswordButtonIsEnabled: Bool = false
        var changePasswordAlertViewIsPresented: Bool = false
        
        var showToast: String = ""
    }
    
    enum Action {
        case backButtonDidTap
        case changePasswordButtonDidTap
        case dismissAlertView
    }
    
    @Published var state = State()
    @Published var currentPassword = ""
    @Published var newPassword = ""
    @Published var checkPassword = ""
    
    public var navigationRouter: NavigationRoutableType
    private let useCase: MyPageUseCaseType
    private let cancelBag = CancelBag()
    
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: MyPageUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        
        observe()
        bindState()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
        case .changePasswordButtonDidTap:
            //TODO: 비밀번호 Reset API 구현
            useCase.changePassword(currentPassword, newPassword, checkPassword)
                .sink(receiveValue: { [weak self] _ in
                    self?.navigationRouter.pop()
                }).store(in: cancelBag)
            
            //TODO: 안되면 alert창
            
            //TODO: 성공하면 pop
            
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
    
    private func bindState() {
        useCase.passwordFailed
//            .merge(with: useCase.passwordFailed)
            .receive(on: RunLoop.main)
            .map { $0.message }
            .assign(to: \.state.showToast, on: self)
            .store(in: cancelBag)
    }
}


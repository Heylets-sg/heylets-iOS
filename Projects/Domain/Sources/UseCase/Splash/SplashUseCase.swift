//
//  SplashUseCase.swift
//  Domain
//
//  Created by 류희재 on 1/17/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

final public class SplashUseCase: SplashUseCaseType {
    private let authRepository: AuthRepositoryType
    private var cancelBag = CancelBag()
    
    public init(authRepository: AuthRepositoryType) {
        self.authRepository = authRepository
    }
    
    public func autoLogin() {
//        authRepository.autoLogin()
//            .catch {
//                
//            }
    }
}
//appService.isLatestVersion()
//    .receive(on: RunLoop.main)
//    .sink { isLatestVersion in
//        
//        guard isLatestVersion else {
//            owner.state.mustUpdateAlertIsPresented = true
//            return
//        }
//        
//        Just(owner.appService.getDeviceIdentifier() ?? "" )
//            .filter { !$0.isEmpty }
//            .flatMap(owner.authService.signIn)
//            .receive(on: RunLoop.main)
//            .map {
//                owner.userDefaultsService.userID = $0.userID
//                owner.userDefaultsService.accessToken = $0.accessToken
//                return WindowDestination.main
//            }
//            .catch { _ in Just(WindowDestination.onboarding) }
//            .sink {
//                owner.windowRouter.switch(to: $0)
//            }
//            .store(in: owner.cancelBag)

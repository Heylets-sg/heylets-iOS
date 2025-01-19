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
    
    public func autoLogin() -> AnyPublisher<Bool, Never> {
        return authRepository.autoLogin()
    }
}

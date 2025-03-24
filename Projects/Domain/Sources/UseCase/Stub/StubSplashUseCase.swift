//
//  StubSplashUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

final public class StubSplashUseCase: SplashUseCaseType {
    public func autoLogin() -> AnyPublisher<Bool, Never> {
        Just(true).eraseToAnyPublisher()
    }
    
    public func tokenRefresh() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}


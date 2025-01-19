//
//  SplashUseCaseType.swift
//  Domain
//
//  Created by 류희재 on 1/17/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol SplashUseCaseType {
    func autoLogin() -> AnyPublisher<Bool, Never>
}

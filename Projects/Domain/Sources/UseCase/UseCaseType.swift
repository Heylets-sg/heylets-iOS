//
//  UseCaseType.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public protocol UseCaseType {
    var myPageUseCase: MyPageUseCaseType { get}
}

public final class HeyUseCase: UseCaseType & ObservableObject {
    var repository: RepositoryType
    public var myPageUseCase: MyPageUseCaseType
    
    public init(repository: RepositoryType) {
        self.repository = repository
        
        myPageUseCase = MyPageUseCase(
            userRepository: repository.userRepository,
            authRepository: repository.authRepository)
    }
}

//
//  StubMainUseCase.swift
//  Domain
//
//  Created by 류희재 on 8/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine

import Core

final public class StubMainUseCase: MainUseCaseType {
    public func fetchTableInfo() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func getProfileInfo() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func addSection(_ sectionId: Int, _ name: String, _ scheduleIsEmpty: Bool) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func deleteSection(_ isCustom: Bool, _ sectionId: Int) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}

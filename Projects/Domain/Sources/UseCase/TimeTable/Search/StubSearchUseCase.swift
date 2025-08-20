//
//  StubSearchUseCase.swift
//  Domain
//
//  Created by 류희재 on 8/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine

final public class StubSearchUseCase: SearchUseCaseType {
    public func getLectureList(_ filterInfo: FilterInfo) -> AnyPublisher<LectureListInfo, Never> {
        return Just(.init()).eraseToAnyPublisher()
    }
    
    public func addCustomModule(_ customModule: CustomModuleInfo) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func getLectureDepartment() -> AnyPublisher<[String], Never> {
        Just([]).eraseToAnyPublisher()
    }
    
    public func addSection(_ sectionId: Int, _ name: String, _ scheduleIsEmpty: Bool) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}

//
//  TodoUseCase.swift
//  Domain
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

final public class TodoUseCase: TodoUsecaseType {
    private let todoRepository: TodoRepositoryType
    
    private var cancelBag = CancelBag()
    
    public init(
        todoRepository: TodoRepositoryType
    ) {
        self.todoRepository = todoRepository
    }
}

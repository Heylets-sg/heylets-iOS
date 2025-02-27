//
//  TodoViewModel.swift
//  TodoFeature
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import Core

public class TodoViewModel: ObservableObject {
    
    enum Action {
        case onAppear
    }
    
    public var windowRouter: WindowRoutable
    private let useCase: TodoUsecaseType

    @Published var groupList: [TodoGroup] = []
    
    private var cancelBag = CancelBag()
    
    public init(
        windowRouter: WindowRoutableType,
        useCase: TodoUsecaseType
    ) {
        self.windowRouter = windowRouter
        self.useCase = useCase
        
        bindState()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getGroup()
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
        }
    }
    
    private func bindState() {
        useCase.todoGroupList
            .receive(on: RunLoop.main)
            .assign(to: \.groupList, on: self)
            .store(in: cancelBag)
    }
}




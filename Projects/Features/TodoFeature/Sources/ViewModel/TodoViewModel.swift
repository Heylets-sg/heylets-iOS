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
    struct State {
        var showItemAlertView: Bool = false
    }
    
    enum Action {
        case onAppear
        case addGroupButtonDidTap
        case deleteItem(Int)
        case deleteGroup(Int)
        case toggleItemCompletedButtonDidTap(Int)
        
        case addItem(Int, String)
        case closeButtonDidTap
        case addTaskButtonDidTap
    }
    
    enum WindowAction {
        case gotoTimeTable
        case gotoMyPage
    }
    
    public var windowRouter: WindowRoutable
    private let useCase: TodoUsecaseType

    @Published var groupList: [TodoGroup] = [] {
        didSet {
            print("💜💜💜💜💜 \(groupList)")
        }
    }
    @Published var state = State()
    
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
            
        case .deleteGroup(let groupId):
            useCase.deleteGroup(groupId)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .deleteItem(let itemId):
            useCase.deleteItem(itemId)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .addGroupButtonDidTap:
            useCase.createGroup()
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .toggleItemCompletedButtonDidTap(let itemId):
            useCase.toggleItemCompleted(itemId)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .addTaskButtonDidTap:
            state.showItemAlertView = true
            
        case .closeButtonDidTap:
            state.showItemAlertView = false
            
        case .addItem(let groupId, let content):
            useCase.createItem(groupId, content)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
        }
    }
    
    func send(_ action: WindowAction) {
        switch action {
        case .gotoTimeTable:
            windowRouter.switch(to: .timetable)
        case .gotoMyPage:
            windowRouter.switch(to: .mypage)
        }
    }
    
    private func bindState() {
        useCase.todoGroupList
            .receive(on: RunLoop.main)
            .assign(to: \.groupList, on: self)
            .store(in: cancelBag)
    }
}




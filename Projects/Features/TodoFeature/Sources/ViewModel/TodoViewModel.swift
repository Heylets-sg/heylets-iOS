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
        var editGroupName: (Int?, String) = (nil, "")
        var showGuestDeniedAlert: Bool = false
        var hiddenTabBar: Bool = false
    }
    
    enum Action {
        case onAppear
        case closeButtonDidTap
        case notRightNowButtonDidTap
    }
    
    enum GroupAction {
        case addGroupButtonDidTap
        case deleteGroupButtonDidTap(Int)
        case changeGroupNameButtonDidTap(Int)
        case changeGroupName
    }
    
    enum ItemAction {
        case addItem(Int, String)
        case editItem(Int, String)
        case toggleItemCompletedButtonDidTap(Int)
        case deleteItemButtonDidTap(Int)
    }
    
    enum WindowAction {
        case gotoTimeTable
        case gotoMyPage
        case gotoLogin
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
    
    func send(_ action: GroupAction) {
        switch action {
        case .addGroupButtonDidTap:
            if useCase.isGuestMode {
                state.showGuestDeniedAlert = true
            } else {
                useCase.createGroup()
                    .sink(receiveValue: { _ in })
                    .store(in: cancelBag)
            }
            
        case .deleteGroupButtonDidTap(let groupId):
            if useCase.isGuestMode {
                state.showGuestDeniedAlert = true
            } else {
                useCase.deleteGroup(groupId)
                    .sink(receiveValue: { _ in })
                    .store(in: cancelBag)
            }
            
        case .changeGroupNameButtonDidTap(let groupId):
            if useCase.isGuestMode {
                state.showGuestDeniedAlert = true
            } else {
                state.showItemAlertView = true
                state.editGroupName.0 = groupId
            }
            
            
        case .changeGroupName:
            guard let groupId = state.editGroupName.0 else { return }
            let groupName = state.editGroupName.1
            useCase.editGroupName(groupId, groupName)
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.state.showItemAlertView = false
                })
                .store(in: cancelBag)
        }
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getGroup()
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .closeButtonDidTap:
            state.showItemAlertView = false
            
        case .notRightNowButtonDidTap:
            state.showGuestDeniedAlert = false
        }
    }
    
    func send(_ action: ItemAction) {
        switch action {
        case .deleteItemButtonDidTap(let itemId):
            useCase.deleteItem(itemId)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .toggleItemCompletedButtonDidTap(let itemId):
            useCase.toggleItemCompleted(itemId)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .addItem(let groupId, let content):
            state.hiddenTabBar = false
            useCase.createItem(groupId, content)
                .receive(on: RunLoop.main)
                .sink(receiveValue: {  _ in })
                .store(in: cancelBag)
            
        case .editItem(let itemId, let content):
            state.hiddenTabBar = false
            useCase.editItem(itemId, content)
                .receive(on: RunLoop.main)
                .sink(receiveValue: {  _ in })
                .store(in: cancelBag)
        }
    }
    
    func send(_ action: WindowAction) {
        switch action {
        case .gotoTimeTable:
            windowRouter.switch(to: .timetable)
        case .gotoMyPage:
            windowRouter.switch(to: .mypage)
        case .gotoLogin:
            windowRouter.switch(to: .login)
        }
    }
    
    private func bindState() {
        useCase.todoGroupList
            .receive(on: RunLoop.main)
            .assign(to: \.groupList, on: self)
            .store(in: cancelBag)
    }
}

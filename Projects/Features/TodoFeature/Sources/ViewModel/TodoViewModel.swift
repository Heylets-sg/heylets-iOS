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
        var addItemEditMode: [Bool] = []
    }
    
    enum Action {
        case onAppear
        case closeButtonDidTap
        case notRightNowButtonDidTap
        case hideKeyboard
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
        case itemDidTap(Int)
        case addTaskButtonDidTap(groupId: Int)
    }
    
    enum WindowAction {
        case gotoTimeTable
        case gotoMyPage
        case gotoLogin
    }
    
    public var windowRouter: WindowRoutable
    private let useCase: TodoUsecaseType
    
    @Published var groupList: [TodoGroup] = []
    @Published var state = State()
    @Published var newItem: (groupId: Int?, content: String) = (nil, "") {
        didSet {
            print(newItem.groupId, newItem.content)
        }
    }
    
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
            
        case .hideKeyboard:
            resetEditMode()
            guard let groupId = newItem.groupId else { return }
            useCase.createItem(groupId, newItem.content)
                .receive(on: RunLoop.main)
                .sink(receiveValue: {  [weak self] _ in
                    self?.state.hiddenTabBar = false
                    self?.newItem = (nil, "")
                })
                .store(in: cancelBag)
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
                .sink(receiveValue: {  [weak self] _ in
                    self?.newItem = (nil, "")
                })
                .store(in: cancelBag)
            
        case .editItem(let itemId, let content):
            state.hiddenTabBar = false
            useCase.editItem(itemId, content)
                .receive(on: RunLoop.main)
                .sink(receiveValue: {  _ in })
                .store(in: cancelBag)
            
        case .itemDidTap(let itemId):
            resetAddEditMode()
            for groupIndex in groupList.indices {
                for itemIndex in groupList[groupIndex].items.indices {
                    groupList[groupIndex].items[itemIndex].isEditing = (groupList[groupIndex].items[itemIndex].id == itemId)
                }
            }
            
        case .addTaskButtonDidTap(let groupId):
            for groupIndex in groupList.indices {
                groupList[groupIndex].isAddItemMode = (groupList[groupIndex].id == groupId)
            }
            state.hiddenTabBar = true
            resetEditMode()
            newItem.groupId = groupId
        }
    }
    
    private func bindState() {
        useCase.todoGroupList
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] groupList in
                self?.state.addItemEditMode = Array(repeating: false, count: groupList.count)
            })
            .assign(to: \.groupList, on: self)
            .store(in: cancelBag)
    }
}

extension TodoViewModel {
    private func resetEditMode() {
        groupList.indices.forEach { groupIndex in
            groupList[groupIndex].items.indices.forEach { itemIndex in
                groupList[groupIndex].items[itemIndex].isEditing = false
            }
        }
    }
    
    private func resetAddEditMode() {
        groupList.indices.forEach { groupList[$0].isAddItemMode = false }
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
}

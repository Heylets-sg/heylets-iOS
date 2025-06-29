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
        var showEtcView: Bool = false
        var isLoading = false
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
        case loginButtonDidTap
    }
    
    public var windowRouter: WindowRoutable
    private let useCase: TodoUsecaseType
    
    @Published var groupList: [TodoGroup] = []
    @Published var etcViewList: [(groupId: Int, isVisible: Bool)] = []
    @Published var newItem: (groupId: Int?, content: String) = (nil, "")
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
            Analytics.shared.track(.clickAddTodoGroup)
            if !checkGuestMode() {
                useCase.createGroup()
                    .sink(receiveValue: { _ in
                        Analytics.shared.track(.todoGroupAdded)
                    })
                    .store(in: cancelBag)
            }
        case .deleteGroupButtonDidTap(let groupId):
            if !checkGuestMode() {
                useCase.deleteGroup(groupId)
                    .sink(receiveValue: { _ in })
                    .store(in: cancelBag)
            }
        case .changeGroupNameButtonDidTap(let groupId):
            if !checkGuestMode() {
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
                .receive(on: RunLoop.main)
                .assignLoading(to: \.state.isLoading, on: self)
                .sink(receiveValue: { _ in })
                .store(in: cancelBag)
            
        case .closeButtonDidTap:
            state.showItemAlertView = false
            
        case .notRightNowButtonDidTap:
            Analytics.shared.track(.clickGuestConfirmReject)
            state.showGuestDeniedAlert = false
            
        case .hideKeyboard:
            state.hiddenTabBar = false
            resetEditMode()
            addItem()
        }
    }
    
    func send(_ action: ItemAction) {
        switch action {
        case .deleteItemButtonDidTap(let itemId):
            if !checkGuestMode() {
                useCase.deleteItem(itemId)
                    .sink(receiveValue: { _ in })
                    .store(in: cancelBag)
            }
        case .toggleItemCompletedButtonDidTap(let itemId):
            if !checkGuestMode() {
                useCase.toggleItemCompleted(itemId)
                    .sink(receiveValue: { _ in })
                    .store(in: cancelBag)
            }
        case .addItem:
            if !checkGuestMode() {
//                Analytics.shared.track(.taskAdded)
                state.hiddenTabBar = false
                addItem()
            }
        case .editItem(let itemId, let content):
            if !checkGuestMode() {
                state.hiddenTabBar = false
                useCase.editItem(itemId, content)
                    .receive(on: RunLoop.main)
                    .sink(receiveValue: {  _ in })
                    .store(in: cancelBag)
            }
        case .itemDidTap(let itemId):
            if !checkGuestMode() {
                resetAddEditMode()
                for groupIndex in groupList.indices {
                    for itemIndex in groupList[groupIndex].items.indices {
                        groupList[groupIndex].items[itemIndex].isEditing = (groupList[groupIndex].items[itemIndex].id == itemId)
                    }
                }
            }
        case .addTaskButtonDidTap(let groupId):
            if !checkGuestMode() {
                for groupIndex in groupList.indices {
                    groupList[groupIndex].isAddItemMode = (groupList[groupIndex].id == groupId)
                }
                state.hiddenTabBar = true
                resetEditMode()
                newItem.groupId = groupId
            }
        }
    }
    
    private func bindState() {
        useCase.todoGroupList
            .receive(on: RunLoop.main)
            .handleEvents(receiveOutput: { [weak self] groupList in
                self?.state.addItemEditMode = Array(repeating: false, count: groupList.count)
                self?.etcViewList = groupList.map { (groupId: $0.id, isVisible: false) }
            })
            .assign(to: \.groupList, on: self)
            .store(in: cancelBag)
    }
}

extension TodoViewModel {
    private func addItem() {
        guard let groupId = newItem.groupId else { return }
        Analytics.shared.track(.clickAddTask(
            groupName: "", 
            content: newItem.content
        ))
        useCase.createItem(groupId, newItem.content)
            .receive(on: RunLoop.main)
            .handleEvents(receiveRequest: { [weak self] _ in
                self?.resetAddEditMode()
            })
            .sink(receiveValue: {  [weak self] _ in
                Analytics.shared.track(.taskAdded)
                self?.newItem = (nil, "")
            })
            .store(in: cancelBag)
    }
    
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
    
    private func checkGuestMode() -> Bool {
        if useCase.isGuestMode {
            state.showGuestDeniedAlert = true
        }
        return useCase.isGuestMode
    }
    
    func send(_ action: WindowAction) {
        switch action {
        case .gotoTimeTable:
            windowRouter.switch(to: .timetable)
        case .gotoMyPage:
            windowRouter.switch(to: .mypage)
        case .loginButtonDidTap:
            Analytics.shared.track(.clickGuestConfirmReject)
            windowRouter.switch(to: .login)
        }
    }
}

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
    private let timeTableId: Int
    private let todoRepository: TodoRepositoryType
    
    private var cancelBag = CancelBag()
    
    public init(
        timeTableId: Int,
        todoRepository: TodoRepositoryType
    ) {
        self.timeTableId = timeTableId
        self.todoRepository = todoRepository
    }
    
    public var todoGroupList = CurrentValueSubject<[TodoGroup], Never>([])
    
}

public extension TodoUseCase {
    func deleteItem(
        _ itemId: Int
    ) -> AnyPublisher<Void, Never> {
        todoRepository.deleteItem(itemId)
            .catch { _ in Empty() }
            .flatMap(getGroup)
            .eraseToAnyPublisher()
            
    }
    
    func deleteGroup(
        _ groupId: Int
    ) -> AnyPublisher<Void, Never> {
        todoRepository.deleteGroup(groupId)
            .catch { _ in Empty() }
            .flatMap(getGroup)
            .eraseToAnyPublisher()
    }
    
    func getGroup() -> AnyPublisher<Void, Never> {
        todoRepository.getGroup(timeTableId)
            .map { _ in }
            .catch {  _ in Empty() }
            .eraseToAnyPublisher()
    }
    
    func editItem(
        _ itemId: Int,
        _ content: String
    ) -> AnyPublisher<Void, Never> {
        todoRepository.editItem(itemId, content)
            .catch { _ in Empty() }
            .flatMap(updateTodoItem)
            .eraseToAnyPublisher()
    }
    
    func toggleItemCompleted(
        _ itemId: Int
    ) -> AnyPublisher<Void, Never> {
        todoRepository.toggleItemCompleted(itemId)
            .catch { _ in Empty() }
            .flatMap(updateTodoItem)
            .eraseToAnyPublisher()
    }
    
    func editGroupName(
        _ groupId: Int,
        _ name: String
    ) -> AnyPublisher<Void, Never> {
        todoRepository.editGroupName(groupId, name)
            .catch { _ in Empty() }
            .flatMap(updateTodoGroup)
            .eraseToAnyPublisher()
    }
    
    func createGroup(
        _ name: String,
        _ type: String
    ) -> AnyPublisher<Void, Never> {
        todoRepository.createGroup(name, type, timeTableId)
            .catch { _ in Empty() }
            .flatMap { [weak self] group in
                guard let self else { return Empty<Void, Never>().eraseToAnyPublisher() }
                var groups = todoGroupList.value
                groups.append(group)
                todoGroupList.send(groups)
                return Just(()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func createItem(
        _ groupId: Int,
        _ content: String
    ) -> AnyPublisher<Void, Never> {
        todoRepository.createItem(groupId, content)
            .catch { _ in Empty() }
            .flatMap(updateTodoItem)
            .eraseToAnyPublisher()
    }
}
    
public extension TodoUseCase {
    func updateTodoItem(item: TodoItem) -> AnyPublisher<Void, Never> {
        var groups = todoGroupList.value
        
        for groupIndex in groups.indices {
            //아이디 있으면 변경, 없으면 추가
            if let itemIndex = groups[groupIndex].items.firstIndex(where: { $0.id == item.id }) {
                groups[groupIndex].items[itemIndex] = item
            } else {
                groups[groupIndex].items.append(item)
            }
            todoGroupList.send(groups)
            return Just(()).eraseToAnyPublisher()
        }
        return Empty().eraseToAnyPublisher()
    }
    

    func updateTodoGroup(group: TodoGroup) -> AnyPublisher<Void, Never> {
        var groups = todoGroupList.value
        
        for groupIndex in groups.indices {
            if groups[groupIndex].id == group.id {
                groups[groupIndex] = group
                todoGroupList.send(groups)
                return Just(()).eraseToAnyPublisher()
            }
        }
        return Empty().eraseToAnyPublisher()
    }


}

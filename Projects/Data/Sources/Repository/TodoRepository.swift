//
//  TodoRepository.swift
//  Data
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct TodoRepository: TodoRepositoryType {
    private let service: TodoServiceType
    
    public init(service: TodoServiceType) {
        self.service = service
    }
    
    public func deleteItem(
        _ itemId: Int
    ) -> AnyPublisher<Void, Error> {
        service.deleteItem(itemId)
            .asVoidWithGeneralError()
    }
    
    public func deleteGroup(
        _ groupId: Int
    ) -> AnyPublisher<Void, Error> {
        service.deleteGroup(groupId)
            .asVoidWithGeneralError()
    }
    
    public func getGroup(
        _ timeTableId: Int
    ) -> AnyPublisher<[TodoGroup], Error> {
        service.getGroup(timeTableId)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func editItem(
        _ itemId: Int,
        _ content: String
    ) -> AnyPublisher<TodoItem, Error> {
        service.editItem(itemId, content)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func toggleItemCompleted(
        _ itemId: Int
    ) -> AnyPublisher<TodoItem, Error> {
        service.toggleItemCompleted(itemId)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func editGroupName(
        _ groupId: Int,
        _ name: String
    ) -> AnyPublisher<TodoGroup, Error> {
        service.editGroupName(groupId, name)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func createGroup(
        _ name: String,
        _ type: String,
        _ timeTableSectionId: Int
    ) -> AnyPublisher<TodoGroup, Error> {
        service.createGroup(name, type, timeTableSectionId)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func createItem(
        _ groupId: Int,
        _ content: String
    ) -> AnyPublisher<TodoItem, Error> {
        service.createItem(groupId, content)
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
}

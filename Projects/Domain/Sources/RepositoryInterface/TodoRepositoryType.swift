//
//  TodoRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol TodoRepositoryType {
    func deleteItem(
        _ itemId: Int
    ) -> AnyPublisher<Void, Error>
    
    func deleteGroup(
        _ groupId: Int
    ) -> AnyPublisher<Void, Error>
    
    func getGroup(
        _ timeTableId: Int
    ) -> AnyPublisher<[TodoGroup], Error>
    
    func editItem(
        _ itemId: Int,
        _ content: String
    ) -> AnyPublisher<TodoItem, Error>
    
    func toggleItemCompleted(
        _ itemId: Int
    ) -> AnyPublisher<TodoItem, Error>
    
    func editGroupName(
        _ groupId: Int,
        _ name: String
    ) -> AnyPublisher<TodoGroup, Error>
    
    func createGroup(
        _ name: String,
        _ type: String,
        _ timeTableSectionId: Int
    ) -> AnyPublisher<TodoGroup, Error>
    
    func createItem(
        _ groupId: Int,
        _ content: String
    ) -> AnyPublisher<TodoItem, Error>
}

//
//  TodoService.swift
//  Networks
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Foundation
import Combine

public typealias TodoService = BaseService<TodoAPI>

public protocol TodoServiceType {
    func deleteItem(
        _ itemId: Int
    ) -> NetworkVoidResponse
    
    func deleteGroup(
        _ groupId: Int
    ) -> NetworkVoidResponse
    
    func getGroup(
        _ timeTableId: Int
    ) -> NetworkDecodableResponse<TodoResult>
    
    func editItem(
        _ itemId: Int,
        _ content: String
    ) -> NetworkDecodableResponse<ItemResult>
    
    func toggleItemCompleted(
        _ itemId: Int
    ) -> NetworkDecodableResponse<ItemResult>
    
    func editGroupName(
        _ groupId: Int,
        _ name: String
    ) -> NetworkDecodableResponse<GroupResult>
    
    func createGroup(
        _ name: String,
        _ type: String,
        _ timeTableSectionId: Int
    ) -> NetworkDecodableResponse<GroupResult>
    
    func createItem(
        _ groupId: Int,
        _ content: String
    ) -> NetworkDecodableResponse<ItemResult>
}

extension TodoService: TodoServiceType {
    public func deleteItem(_ itemId: Int) -> NetworkVoidResponse {
        requestWithNoResult(.deleteItem(itemId))
    }
    
    public func deleteGroup(_ groupId: Int) -> NetworkVoidResponse {
        requestWithNoResult(.deleteItem(groupId))
    }
    
    public func getGroup(_ timeTableId: Int) -> NetworkDecodableResponse<TodoResult> {
        requestWithResult(.getGroup(timeTableId))
    }
    
    public func editItem(_ itemId: Int, _ content: String) -> NetworkDecodableResponse<ItemResult> {
        let request = ItemRequest(content)
        return requestWithResult(.editItem(itemId, request))
    }
    
    public func toggleItemCompleted(_ itemId: Int) -> NetworkDecodableResponse<ItemResult> {
        requestWithResult(.toggleItemCompleted(itemId))
    }
    
    public func editGroupName(_ groupId: Int, _ groupName: String) -> NetworkDecodableResponse<GroupResult> {
        let request = EditGroupNameRequest(groupName)
        return requestWithResult(.editGroupName(groupId, request))
    }
    
    public func createGroup(
        _ groupName: String,
        _ type: String,
        _ timeTableSectionId: Int
    ) -> NetworkDecodableResponse<GroupResult> {
        let request = CreateGroupRequest(
            groupName,
            type, 
            timeTableSectionId
        )
        return requestWithResult(.createGroup(request))
    }
    
    public func createItem(_ groupId: Int, _ content: String) -> NetworkDecodableResponse<ItemResult> {
        let request = ItemRequest(content)
        return requestWithResult(.createItem(groupId, request))
    }
    
}

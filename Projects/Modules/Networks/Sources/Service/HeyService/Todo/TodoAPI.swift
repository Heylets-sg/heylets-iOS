//
//  TodoAPI.swift
//  Networks
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Foundation

import Domain

public enum TodoAPI {
    case deleteItem(Int)
    case deleteGroup(Int)
    case getGroup(Int)
    case editItem(Int, ItemRequest)
    case toggleItemCompleted(Int)
    case editGroupName(Int, EditGroupNameRequest)
    case createGroup(CreateGroupRequest)
    case createItem(Int, ItemRequest)
}

extension TodoAPI: BaseAPI {
    public var connectWebHook: Bool {
        return false
    }
    
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
        switch self {
        case .deleteItem(let itemId):
            return Paths.deleteItem.replacingOccurrences(
                of: "{itemId}",
                with: "\(itemId)"
            )
        case .deleteGroup(let groupId):
            return Paths.deleteGroup.replacingOccurrences(
                of: "{groupId}",
                with: "\(groupId)"
            )
        case .getGroup(let timeTableId):
            return Paths.getGroup.replacingOccurrences(
                of: "{timeTableId}",
                with: "\(timeTableId)"
            )
        case .editItem(let itemId, _):
            return Paths.editItem.replacingOccurrences(
                of: "{itemId}",
                with: "\(itemId)"
            )
        case .toggleItemCompleted(let itemId):
            return Paths.toggleItemCompleted.replacingOccurrences(
                of: "{itemId}",
                with: "\(itemId)"
            )
        case .editGroupName(let groupId, _):
            return Paths.editGroupName.replacingOccurrences(
                of: "{groupId}",
                with: "\(groupId)"
            )
        case .createGroup:
            return Paths.createGroup
            
        case .createItem(let groupId, _):
            return Paths.createItem.replacingOccurrences(
                of: "{groupId}",
                with: "\(groupId)"
            )
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .deleteItem:
            return .delete
        case .deleteGroup:
            return .delete
        case .getGroup:
            return .get
        case .editItem:
            return .patch
        case .toggleItemCompleted:
            return .patch
        case .editGroupName:
            return .patch
        case .createGroup:
            return .post
        case .createItem:
            return .post
        }
    }
    
    public var task: Task {
        switch self {
        case .deleteItem:
            return .requestPlain
        case .deleteGroup:
            return .requestPlain
        case .getGroup:
            return .requestPlain
        case .editItem(_, let request):
            return .requestJSONEncodable(request)
        case .toggleItemCompleted:
            return .requestPlain
        case .editGroupName(_, let request):
            return .requestJSONEncodable(request)
        case .createGroup(let request):
            return .requestJSONEncodable(request)
        case .createItem(_, let request):
            return .requestJSONEncodable(request)
        }
    }
    
    public var headers: [String : String]? {
        return APIHeaders.headerWithAccessToken
    }
}

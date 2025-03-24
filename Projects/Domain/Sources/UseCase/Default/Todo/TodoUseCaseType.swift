//
//  TodoUsecaseType.swift
//  Domain
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Foundation
import Combine

public protocol TodoUsecaseType {
    var isGuestMode: Bool { get }
    var todoGroupList: CurrentValueSubject<[TodoGroup], Never> { get }
    
    func deleteItem(
        _ itemId: Int
    ) -> AnyPublisher<Void, Never>
    
    func deleteGroup(
        _ groupId: Int
    ) -> AnyPublisher<Void, Never>
    
    func getGroup() -> AnyPublisher<Void, Never>
    
    func editItem(
        _ itemId: Int,
        _ content: String
    ) -> AnyPublisher<Void, Never>
    
    func toggleItemCompleted(
        _ itemId: Int
    ) -> AnyPublisher<Void, Never>
    
    func editGroupName(
        _ groupId: Int,
        _ name: String
    ) -> AnyPublisher<Void, Never>
    
    func createGroup() -> AnyPublisher<Void, Never>
    
    func createItem(
        _ groupId: Int,
        _ content: String
    ) -> AnyPublisher<Void, Never>
}

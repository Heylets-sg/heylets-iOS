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
}

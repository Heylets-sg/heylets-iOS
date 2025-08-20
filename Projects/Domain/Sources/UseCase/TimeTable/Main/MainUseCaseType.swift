//
//  MainUseCaseType.swift
//  Domain
//
//  Created by 류희재 on 8/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine

public protocol MainUseCaseType {
    func fetchTableInfo() -> AnyPublisher<Void, Never>
    func getProfileInfo() -> AnyPublisher<Void, Never>
    func addSection(_ sectionId: Int, _ name: String, _ scheduleIsEmpty: Bool) -> AnyPublisher<Void, Never>
    func deleteSection(_ isCustom: Bool, _ sectionId: Int) -> AnyPublisher<Void, Never>
}

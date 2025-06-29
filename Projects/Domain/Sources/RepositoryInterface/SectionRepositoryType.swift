//
//  SectionRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol SectionRepositoryType {
    func deleteAllSection(
        _ tableId: Int
    ) -> AnyPublisher<Void, DeleteAllSectionError>
    
    func deleteSection(
        _ tableId: Int,
        _ sectionId: Int
    ) -> AnyPublisher<Void, Error>
    
    //추가하자마자 전체 API 불러올 생각이어서 일단 Void
    func addSection(
        _ tableId: Int,
        _ sectionId: Int,
        _ memo: String
    ) -> AnyPublisher<Void, AddSectionError>
}

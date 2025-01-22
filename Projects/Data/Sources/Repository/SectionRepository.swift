//
//  SectionRepository.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct SectionRepository: SectionRepositoryType {
    private let service: SectionServiceType
    
    public init(service: SectionServiceType) {
        self.service = service
    }
    
    public func deleteAllSection(
        _ tableId: String
    ) -> AnyPublisher<Void, Error> {
        service.deleteAllSection(tableId)
            .asVoidWithGeneralError()
    }
    
    public func deleteSection(
        _ tableId: String,
        _ sectionId: Int
    ) -> AnyPublisher<Void, Error> {
        service.deleteSection(tableId, sectionId)
            .asVoidWithGeneralError()
    }
    
    public func addSection(
        _ tableId: String,
        _ sectionId: Int,
        _ memo: String
    ) -> AnyPublisher<Void, AddSectionError> {
        let request: AddSectionRequest = .init(sectionId, memo)
        return service.addSection(tableId, request)
            .asVoid()
            .mapError { error in
                if let errorCode = error.isInvalidStatusCodeWithMessage() {
                    return AddSectionError.error(with: errorCode)
                } else {
                    return .unknown
                }
            }
            .eraseToAnyPublisher()
    }
}

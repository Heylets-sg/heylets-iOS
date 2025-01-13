//
//  SectionService.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias SectionService = BaseService<SectionAPI>

public protocol SectionServiceType {
    func deleteAllSection(
        _ tableId: String
    ) -> NetworkDecodableResponse<DeleteAllSectionResult>
    
    func deleteSection(
        _ tableId: String,
        _ sectionId: String
    ) -> NetworkVoidResponse
    
    func addSection(
        _ tableId: String,
        _ request: AddSectionRequest
    ) -> NetworkDecodableResponse<SectionInfoResult>
}

extension SectionService: SectionServiceType {
    public func deleteAllSection(
        _ tableId: String
    ) -> NetworkDecodableResponse<DeleteAllSectionResult> {
        requestWithResult(.deleteAllSection(tableId))
    }
    
    public func deleteSection(
        _ tableId: String,
        _ sectionId: String
    ) -> NetworkVoidResponse {
        requestWithNoResult(.deleteSection(tableId, sectionId))
    }
    
    public func addSection(
        _ tableId: String,
        _ request: AddSectionRequest
    ) -> NetworkDecodableResponse<SectionInfoResult> {
        requestWithResult(.addSection(tableId, request))
    }
}

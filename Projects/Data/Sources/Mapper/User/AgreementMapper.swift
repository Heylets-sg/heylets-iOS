//
//  AgreementMapper.swift
//  Data
//
//  Created by 류희재 on 2/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Core
import Domain
import Networks

extension AgreementInfo {
    public func toDTO() -> AgreementRequest {
        .init(
            type: type,
            agreed: agreed,
            version: version
        )
    }
}

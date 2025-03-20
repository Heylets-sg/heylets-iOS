//
//  ReferralRepository.swift
//  Data
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct ReferralRepository: ReferralRepositoryType {
    private let service: ReferralServiceType
    
    public init(service: ReferralServiceType) {
        self.service = service
    }
    
    public func getReferralCode() -> AnyPublisher<String, Error> {
        service.getReferralCode()
            .map { $0.code }
            .mapToGeneralError()
    }
    
    public func validateReferralCode(_ code: String) -> AnyPublisher<Bool, Error> {
        let request: ValidateReferralCodeRequest = .init(code)
        return service.validateReferralCode(request)
            .map { $0.isValid }
            .mapToGeneralError()
    }
}

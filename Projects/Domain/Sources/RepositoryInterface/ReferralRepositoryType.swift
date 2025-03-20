//
//  ReferralRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol ReferralRepositoryType {
    func getReferralCode() -> AnyPublisher<String, Error>
    
    func validateReferralCode(_ code: String) -> AnyPublisher<Bool, Error>
}

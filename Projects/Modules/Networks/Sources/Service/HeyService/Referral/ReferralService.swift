//
//  ReferralService.swift
//  Networks
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias ReferralService = BaseService<ReferralAPI>

public protocol ReferralServiceType {
    func getReferralCode() -> NetworkDecodableResponse<ReferralCodeResult>
    
    func validateReferralCode(
        _ code: String
    ) -> NetworkDecodableResponse<ValidateReferralCodeResult>
}

extension ReferralService: ReferralServiceType {
    public func getReferralCode() -> NetworkDecodableResponse<ReferralCodeResult> {
        requestWithResult(.getReferralCode)
    }
    
    public func validateReferralCode(
        _ code: String
    ) -> NetworkDecodableResponse<ValidateReferralCodeResult> {
        requestWithResult(.validateReferralCode(code))
    }
}


//
//  GuestService.swift
//  Networks
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Foundation
import Combine

public typealias GuestService = BaseService<GuestAPI>

public protocol GuestServiceType {
    func changeGuestUniversity(
        _ university: String
    ) -> NetworkVoidResponse
    
    func startGuestMode(
        _ university: String
    ) -> NetworkDecodableResponse<AuthResult>
    
    func convertToMember(
        _ request: SignUpRequest
    ) -> NetworkVoidResponse
}

extension GuestService: GuestServiceType {
    public func changeGuestUniversity(
        _ university: String
    ) -> NetworkVoidResponse {
        let request: UniversityRequest = .init(university)
        return requestWithNoResult(.changeGuestUniversity(request))
    }
    
    public func startGuestMode(
        _ university: String
    ) -> NetworkDecodableResponse<AuthResult> {
        requestWithResult(.startGuestMode(university))
    }
    
    public func convertToMember(_ request: SignUpRequest) -> NetworkVoidResponse {
        <#code#>
    }
}

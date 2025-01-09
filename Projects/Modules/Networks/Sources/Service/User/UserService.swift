//
//  UserService.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias UserService = BaseService<UserAPI>

public protocol UserServiceType {
    func deleteProfileImg() -> NetworkVoidResponse
    
    func getProfile() -> NetworkDecodableResponse<MyProfileResult>
    
    func patchNickName(
        _ request: EditNameRequest
    ) -> NetworkVoidResponse
    
    func patchAcademicInfo(
        _ request: AcademicDTO
    ) -> NetworkDecodableResponse<AcademicDTO>

}

extension UserService: UserServiceType {
    public func deleteProfileImg() -> NetworkVoidResponse {
        requestWithNoResult(.deleteProfileImg)
    }
    
    public func getProfile() -> NetworkDecodableResponse<MyProfileResult> {
        requestWithResult(.getProfile)
    }
    
    public func patchNickName(
        _ request: EditNameRequest
    ) -> NetworkVoidResponse {
        requestWithNoResult(.patchNickName(request))
    }
    
    public func patchAcademicInfo(
        _ request: AcademicDTO
    ) -> NetworkDecodableResponse<AcademicDTO> {
        requestWithResult(.patchAcademicInfo(request))
    }
}

//
//  UserRepository.swift
//  Data
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks

public struct UserRepository: UserRepositoryType {
    private let service: UserServiceType
    
    public init(service: UserServiceType) {
        self.service = service
    }
    
    public func deleteProfileImg() -> AnyPublisher<Void, Error> {
        service.deleteProfileImg()
            .asVoidWithGeneralError()
    }
    
    public func getProfile() -> AnyPublisher<ProfileInfo, Error> {
        service.getProfile()
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func patchNickName(
        _ nickName: String
    ) -> AnyPublisher<Void, Error> {
        let request: EditNameRequest = .init(nickName)
        return service.patchNickName(request)
            .asVoidWithGeneralError()
    }
    
//    public func patchAcademicInfo(
//        _ matriculationYear: Int,
//        _ academicYear: Int,
//        _ studentId: String
//    ) {
//        let request: AcademicDTO = .init(matriculationYear, academicYear, studentId)
//        return service.patchAcademicInfo(request)
//            .
//    }
    
}

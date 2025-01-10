//
//  UserRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol UserRepositoryType {
    func deleteProfileImg() -> AnyPublisher<Void, Error>
    func getProfile() -> AnyPublisher<ProfileInfo, Error>
    func patchNickName(
        _ nickName: String
    ) -> AnyPublisher<Void, Error>
    
    //TODO: 이거 안 쓸거 같아서 일단 구현 ㄴㄴ
//    func patchAcademicInfo(
//        _ matriculationYear: Int,
//        _ academicYear: Int,
//        _ studentId: String
//    )
}

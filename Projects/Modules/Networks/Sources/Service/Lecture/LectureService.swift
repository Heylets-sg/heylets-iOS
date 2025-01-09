//
//  LectureService.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias LectureService = BaseService<LectureAPI>

public protocol LectureServiceType {
    func getLectureDetailInfo(_ lectureId: Int) -> AnyPublisher<LectureDetailResult, HeyNetworkError>
    func getLectureList() -> AnyPublisher<LectureListResult, HeyNetworkError>
    func getLectureListWithKeyword(_ keyword: String) -> AnyPublisher<LectureListResult, HeyNetworkError>
}

extension LectureService: LectureServiceType {
    public func getLectureDetailInfo(_ lectureId: Int) -> AnyPublisher<LectureDetailResult, HeyNetworkError> {
        requestWithResult(.getLectureDetailInfo(lectureId))
    }
    
    public func getLectureList() -> AnyPublisher<LectureListResult, HeyNetworkError> {
        requestWithResult(.getLectureList)
    }
    
    public func getLectureListWithKeyword(_ keyword: String) -> AnyPublisher<LectureListResult, HeyNetworkError> {
        requestWithResult(.getLectureListWithKeyword(keyword))
    }
}

//public struct StubAuthService: AuthServiceType {
//
//}


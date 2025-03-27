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
    func getLectureDetailInfo(
        _ lectureId: Int
    ) -> NetworkDecodableResponse<LectureDetailResult>
    
    func getLectureList() -> NetworkDecodableResponse<LectureListResult>
    
    func getLectureListWithKeyword(
        _ filterParameters: Parameters
    ) -> NetworkDecodableResponse<LectureListResult>
    
    func getLectureDepartment(
        _ university: String
    ) -> NetworkDecodableResponse<DepartmentResult>
    
    func getKeyword() -> NetworkDecodableResponse<KeywordResult>
}

extension LectureService: LectureServiceType {
    public func getLectureDetailInfo(
        _ lectureId: Int
    ) -> AnyPublisher<LectureDetailResult, HeyNetworkError> {
        requestWithResult(.getLectureDetailInfo(lectureId))
    }
    
    public func getLectureList() -> AnyPublisher<LectureListResult, HeyNetworkError> {
        requestWithResult(.getLectureList)
    }
    
    public func getLectureListWithKeyword(
        _ filterParameters: Parameters
    ) -> AnyPublisher<LectureListResult, HeyNetworkError> {
        requestWithResult(.getLectureListWithKeyword(filterParameters))
    }
    
    public func getLectureDepartment(
        _ university: String
    ) -> NetworkDecodableResponse<DepartmentResult> {
        requestWithResult(.getLectureDepartment(university))
    }
    
    public func getKeyword() -> NetworkDecodableResponse<KeywordResult> {
        requestWithResult(.getKeyword)
    }
}


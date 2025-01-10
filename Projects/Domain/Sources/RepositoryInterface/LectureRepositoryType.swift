//
//  LectureRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol LectureRepositoryType {
    //TODO: ⭐️ 다시 확인
    func getLectureDetailInfo(
        _ lectureId: Int
    ) -> AnyPublisher<LectureInfo, Error>
    
    //TODO: ⭐️ 다시 확인
    func getLectureList() -> AnyPublisher<[LectureInfo], Error>
    
    func getLectureListWithKeyword(
        _ keyword: String
    ) -> AnyPublisher<[LectureInfo], Error>
}

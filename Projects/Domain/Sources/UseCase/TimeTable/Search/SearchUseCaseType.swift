//
//  SearchUseCaseTYpe.swift
//  Domain
//
//  Created by 류희재 on 8/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine

public protocol SearchUseCaseType {
    //강의 목록 불러오기
    func getLectureList(
        _ filterInfo: FilterInfo
    ) -> AnyPublisher<LectureListInfo, Never>
    //커스텀 모듈 추가하기
    func addCustomModule(_ customModule: CustomModuleInfo) -> AnyPublisher<Void, Never>
    //학과 찾기
    func getLectureDepartment() -> AnyPublisher<[String], Never>
    // 강의 추가하기
    func addSection(_ sectionId: Int, _ name: String, _ scheduleIsEmpty: Bool) -> AnyPublisher<Void, Never>
}

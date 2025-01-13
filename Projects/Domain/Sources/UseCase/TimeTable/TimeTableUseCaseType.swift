//
//  TimeTableUseCaseType.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Foundation
import Combine

public protocol TimeTableUseCaseType {
    func getLectureList() -> AnyPublisher<([SectionInfo], [Week]), Error>
    // lectureInfo -> sectionInfo, weekInfo
    
    func getTableDetailInfo(
        _ tableId: String
    ) -> AnyPublisher<TimeTableInfo, Error>
    
}

public protocol TimeTableDetailUseCaseType {
    var lectureInfo: SectionInfo { get }
    
    var deleteModuleFailed: PassthroughSubject<String, Never> { get }
    
    func deleteTable(
        _ tableId: String
    ) -> AnyPublisher<Void, Error>
}

public protocol TimeTableSearchUseCaseType {
    var addModuleFailed: PassthroughSubject<String, Never> { get }
    
    // 강의 조회
    func getLectureListWithKeyword(
        _ keyword: String
    ) -> AnyPublisher<[LectureInfo], Error>
    
    // 없는 모듈 report 하기 -> API 어디감?
    
    // 커스텀 모듈 추가
    func addCustomModule(
        _ tableId: String,
        _ customModuleInfo: CustomModuleInfo
    ) -> AnyPublisher<CustomModuleInfo, Error>
}

public protocol TimeTableSettingUseCaseType {
    func changeTimetableName(
        _ tableId: String,
        _ tableName: String
    ) -> AnyPublisher<Void, Error>
    
    func getThemeList() -> AnyPublisher<[Theme], Error>
}

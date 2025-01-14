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
    //MARK: Main
    
    // 시간표 상세조회 불러오기
    func getTableDetailInfo(
        _ tableId: String
    ) -> AnyPublisher<TimeTableDetailInfo?, Never>
    
    // 강의 삭제하기
//    func deleteModule(
//        _ tableId: String
//    ) -> AnyPublisher<Void, Error>
    
//    var deleteModuleFailed: PassthroughSubject<String, Never> { get } // 강의 삭제 실패
    
    
    //MARK: Detail
//    var lectureInfo: SectionInfo { get } // 상세 강의
    
    
    
//    
//    //MARK: Search
//    
//    // 강의 조회
//    func getLectureList() -> AnyPublisher<[LectureInfo], Never>
//    
//    // 강의 검색
//    func getLectureListWithKeyword(
//        _ keyword: String
//    ) -> AnyPublisher<[LectureInfo], Never>
//    
//    // 커스텀 모듈 추가
//    func addCustomModule(
//        _ tableId: String,
//        _ customModuleInfo: CustomModuleInfo
//    ) -> AnyPublisher<CustomModuleInfo, Never>
//    
//    var addModuleFailed: PassthroughSubject<String, Never> { get }
//    
//    
}

public protocol TimeTableSettingUseCaseType {
    func changeTimetableName(
        _ tableId: String,
        _ tableName: String
    ) -> AnyPublisher<Void, Never>
    
    func getThemeList() -> AnyPublisher<[Theme], Never>
}

//
//  TimeTableUseCase.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

final public class TimeTableUseCase: TimeTableUseCaseType {
    private let lectureRepository: LectureRepositoryType
    private let scheduleRepository: ScheduleRepositoryType
    private let sectionRepository: SectionRepositoryType
    private let themeRepository: ThemeRepositoryType
    private let timeTableRepository: TimeTableRepositoryType
    
    private var cancelBag = CancelBag()
    
    public init(
        lectureRepository: LectureRepositoryType,
        scheduleRepository: ScheduleRepositoryType,
        sectionRepository: SectionRepositoryType,
        themeRepository: ThemeRepositoryType,
        timeTableRepository: TimeTableRepositoryType
    ) {
        self.lectureRepository = lectureRepository
        self.scheduleRepository = scheduleRepository
        self.sectionRepository = sectionRepository
        self.themeRepository = themeRepository
        self.timeTableRepository = timeTableRepository
    }
}

//MARK: Main
extension TimeTableUseCase {
    // 시간표 상세조회 불러오기
    public func getTableDetailInfo(
        _ tableId: String
    ) -> AnyPublisher<TimeTableDetailInfo?, Never> {
        timeTableRepository.getTableDetailInfo(tableId)
            .map { $0 }
            .catch {  _ in
                //TODO: 실패처리
                return Just(nil).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}







    // 강의 삭제하기
//    public func deleteModule(
//        _ tableId: String
//    ) -> AnyPublisher<Void, Error> {
//        Just(
//    }
    
//    var deleteModuleFailed: PassthroughSubject<String, Never> { get } // 강의 삭제 실패

////MARK: Detail
//extension TimeTableUseCase {
//    var lectureInfo: SectionInfo { get } // 상세 강의
//}
//
////MARK: Search
//extension TimeTableUseCase {
//    //MARK: Search
//    
//    // 강의 조회
//    func getLectureList() -> AnyPublisher<[LectureInfo], Never> {}
//    
//    // 강의 검색
//    func getLectureListWithKeyword(
//        _ keyword: String
//    ) -> AnyPublisher<[LectureInfo], Never> {}
//    
//    // 커스텀 모듈 추가
//    func addCustomModule(
//        _ tableId: String,
//        _ customModuleInfo: CustomModuleInfo
//    ) -> AnyPublisher<CustomModuleInfo, Error> {}
//    
//    var addModuleFailed = PassthroughSubject<String, Never>()
//}
//
////MARK:

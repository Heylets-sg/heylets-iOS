//
//  SearchModuleUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import Core

//MARK: Serach

protocol TimeTableSearchUseCaseType {
    func getLectureList(
        _ filterInfo: FilterInfo
    ) -> AnyPublisher<[SectionInfo], Never>
    //커스텀 모듈 추가하기
    func addCustomModule(_ customModule: CustomModuleInfo) -> AnyPublisher<Void, Never>
    //학과 찾기
    func getLectureDepartment() -> AnyPublisher<[String], Never>
}

final public class TimeTableSearchUseCase: TimeTableSearchUseCaseType {
    private let store: TimeTableStore
    public let lectureRepository: LectureRepositoryType
    public let scheduleRepository: ScheduleRepositoryType
    
    init(
        store: TimeTableStore,
        lectureRepository: LectureRepositoryType,
        scheduleRepository: ScheduleRepositoryType
    ) {
        self.store = store
        self.lectureRepository = lectureRepository
        self.scheduleRepository = scheduleRepository
    }
    
    func getLectureList(
        _ filterInfo: FilterInfo
    ) -> AnyPublisher<[SectionInfo], Never> {
        return lectureRepository.getLectureList(filterInfo)
            .handleEvents(receiveRequest: {  _ in
                Analytics.shared.track(.clickSearchModule(
                    keyword: filterInfo.keyword,
                    department: filterInfo.department ?? "",
                    semester: filterInfo.semester ?? "TERM_2",
                    level: filterInfo.level ?? "",
                    keywordType: filterInfo.keywordType ?? ""
                )
                )
            })
            .catch { _ in
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func addCustomModule(
        _ customModule: CustomModuleInfo
    ) -> AnyPublisher<Void, Never> {
        return scheduleRepository.addCustomModule(store.tableId, customModule)
            .catch { [weak self] error in
                if error.isGuestModeError { self?.store.guestModeError.send(()) }
                else { self?.store.errMessage.send(error.description) }
                return Empty<Void, Never>()
            }
            .flatMap(store.getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    func getLectureDepartment() -> AnyPublisher<[String], Never> {
        lectureRepository.getLectureDepartment(store.profileInfo.value.university.rawValue)
            .map { $0 }
            .catch {  _ in Empty<[String], Never>() }
            .eraseToAnyPublisher()
    }
}

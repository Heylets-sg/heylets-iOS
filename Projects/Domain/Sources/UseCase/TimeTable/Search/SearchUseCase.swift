//
//  SearchModuleUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine
import Core

final public class SearchUseCase: SearchUseCaseType {
    private let store: TimeTableStoreType
    public let lectureRepository: LectureRepositoryType
    public let scheduleRepository: ScheduleRepositoryType
    public let sectionRepository: SectionRepositoryType
    
    init(
        store: TimeTableStoreType,
        lectureRepository: LectureRepositoryType,
        scheduleRepository: ScheduleRepositoryType,
        sectionRepository: SectionRepositoryType
    ) {
        self.store = store
        self.lectureRepository = lectureRepository
        self.scheduleRepository = scheduleRepository
        self.sectionRepository = sectionRepository
    }
    
    public func getLectureList(
        _ filterInfo: FilterInfo
    ) -> AnyPublisher<LectureListInfo, Never> {
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
                return Just(LectureListInfo()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func addCustomModule(
        _ customModule: CustomModuleInfo
    ) -> AnyPublisher<Void, Never> {
        return scheduleRepository.addCustomModule(store.tableId, customModule)
            .catch { [weak self] error in
                if error.isGuestModeError { self?.store.timeTableError.send(.guestModeError) }
                else { self?.store.timeTableError.send(.error(error.description)) }
                return Empty<Void, Never>()
            }
            .flatMap(store.getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    public func getLectureDepartment() -> AnyPublisher<[String], Never> {
        lectureRepository.getLectureDepartment(store.profileInfo.value.university.rawValue)
            .map { $0 }
            .catch {  _ in Empty<[String], Never>() }
            .eraseToAnyPublisher()
    }
    
    public func addSection(_ sectionId: Int, _ name: String, _ scheduleIsEmpty: Bool) -> AnyPublisher<Void, Never> {
        if scheduleIsEmpty {
            store.timeTableError.send(.emptyScheduleError(name))
            return Empty<Void, Never>()
                .eraseToAnyPublisher()
        } else {
            return sectionRepository.addSection(store.tableId, sectionId, "")
                .catch { [weak self] error in
                    if error.isGuestModeError { self?.store.timeTableError.send(.guestModeError) }
                    else { self?.store.timeTableError.send(.error(error.description)) }
                    return Empty<Void, Never>()
                }
                .flatMap(store.getTableDetailInfo)
                .eraseToAnyPublisher()
        }
    }
}

//
//  TimeTableMainUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine

import Core

final public class MainUseCase: MainUseCaseType {
    private var store: TimeTableStoreType
    
    public let userRepository: UserRepositoryType
    public let scheduleRepository: ScheduleRepositoryType
    public let sectionRepository: SectionRepositoryType
    public let timeTableRepository: TimeTableRepositoryType
    public let settingRepository: SettingRepositoryType
    
    private var cancelBag = CancelBag()
    
    public init(
        store: TimeTableStoreType,
        userRepository: UserRepositoryType,
        scheduleRepository: ScheduleRepositoryType,
        sectionRepository: SectionRepositoryType,
        settingRepository: SettingRepositoryType,
        timeTableRepository: TimeTableRepositoryType
    ) {
        self.store = store
        self.userRepository = userRepository
        self.scheduleRepository = scheduleRepository
        self.sectionRepository = sectionRepository
        self.settingRepository = settingRepository
        self.timeTableRepository = timeTableRepository
    }
    
    public func fetchTableInfo() -> AnyPublisher<Void, Never> {
        getTableId()
            .filter { $0 != nil}
            .map { $0! }
            .handleEvents(receiveOutput: { [weak self] id in
                self?.store.tableId = id
            })
            .map { _ in }
            .flatMap(store.getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    public func getProfileInfo() -> AnyPublisher<Void, Never> {
        userRepository.getProfile()
            .handleEvents(receiveOutput: { [weak self] profileInfo in
                self?.store.profileInfo.send(profileInfo)
            })
            .map { _ in }
            .catch {  _ in Empty() }
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
    
    public func deleteSection(_ isCustom: Bool, _ sectionId: Int) -> AnyPublisher<Void, Never> {
        if isCustom {
            return scheduleRepository.deleteLectureModule(store.tableId, sectionId)
                .catch { _ in Empty() }
                .flatMap(store.getTableDetailInfo)
                .eraseToAnyPublisher()
        } else {
            return sectionRepository.deleteSection(store.tableId, sectionId)
                .catch { _ in Empty() }
                .flatMap(store.getTableDetailInfo)
                .eraseToAnyPublisher()
        }
    }
}

extension MainUseCase {
    func getTableId() -> AnyPublisher<Int?, Never> {
        timeTableRepository.getTableList()
            .flatMap { tableId -> AnyPublisher<Int?, Never> in
                if let tableId = tableId {
                    return Just(tableId)
                        .eraseToAnyPublisher()
                } else {
                    return self.timeTableRepository.postTable()
                        .map { $0 }
                        .catch { _ in
                            return  Just(nil).eraseToAnyPublisher()
                        }
                        .eraseToAnyPublisher()
                }
            }
            .catch {  _ in
                Just(nil).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

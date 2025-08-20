//
//  TimeTableSettingUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine

final public class SettingUseCase: SettingUseCaseType {
    private let store: TimeTableStoreType
    
    public let userRepository: UserRepositoryType
    public let sectionRepository: SectionRepositoryType
    public let guestRepository: GuestRepositoryType
    public let timeTableRepository: TimeTableRepositoryType
    public let settingRepository: SettingRepositoryType
    
    init(
        store: TimeTableStoreType,
        userRepository: UserRepositoryType,
        sectionRepository: SectionRepositoryType,
        guestRepository: GuestRepositoryType,
        timeTableRepository: TimeTableRepositoryType,
        settingRepository: SettingRepositoryType
    ) {
        self.store = store
        self.userRepository = userRepository
        self.sectionRepository = sectionRepository
        self.guestRepository = guestRepository
        self.timeTableRepository = timeTableRepository
        self.settingRepository = settingRepository
    }
    
    
    public func changeTimeTableName(_ name: String) -> AnyPublisher<Void, Never> {
        return timeTableRepository.patchTableName(store.tableId, name)
            .catch { [weak self] error in
                if error.isGuestModeError { self?.store.timeTableError.send(.guestModeError) }
                else { self?.store.timeTableError.send(.error(error.description)) }
                return Empty<Void, Never>()
            }
            .flatMap(store.getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    
    
    public func getThemeList() -> AnyPublisher<[Theme], Never> {
        return settingRepository.getThemeList()
            .catch { _ in
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func getSettingInfo() -> AnyPublisher<SettingInfo, Never> {
        return settingRepository.getTimeTableSettingInfo()
            .catch { _ in Empty() }
            .eraseToAnyPublisher()
    }
    
    public func patchSettingInfo(
        _ displayType: DisplayTypeInfo,
        _ theme: String
    ) -> AnyPublisher<Void, Never> {
        return settingRepository.patchTimeTableSettingInfo(displayType, theme)
            .catch { [weak self] error in
                if error.isGuestModeError { self?.store.timeTableError.send(.guestModeError) }
                else { self?.store.timeTableError.send(.error(error.description)) }
                return Empty<Void, Never>()
            }
            .flatMap(store.getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    public func deleteAllSection() -> AnyPublisher<Void, Never> {
        return sectionRepository.deleteAllSection(store.tableId)
            .catch { [weak self] error in
                self?.store.timeTableError.send(.error(error.description))
                return Empty<Void, Never>()
            }
            .flatMap(store.getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    public func handleInviteCodeView() -> AnyPublisher<Bool, Never> {
        return guestRepository.checkGuestMode()
            .flatMap { [weak self] isGuest -> AnyPublisher<Bool, Never> in
                guard let self = self, !isGuest else {
                    return Just(true).eraseToAnyPublisher()
                }
                
                return self.userRepository.getProfile()
                    .map { $0.university.nationality }
                    .map { $0 != .Malaysia }
                    .catch { _ in Just(true) }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func getThemeDetailInfo(_ themeName: String) -> AnyPublisher<[String], Never> {
        return settingRepository.getThemeDetailInfo(themeName)
            .map { [$0.defaultColor] + $0.core + $0.gradient}
            .catch { _ in
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

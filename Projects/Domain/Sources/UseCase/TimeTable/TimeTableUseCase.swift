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
    private let userRepository: UserRepositoryType
    private let lectureRepository: LectureRepositoryType
    private let scheduleRepository: ScheduleRepositoryType
    private let sectionRepository: SectionRepositoryType
    private let settingRepository: SettingRepositoryType
    private let timeTableRepository: TimeTableRepositoryType
    
    private var cancelBag = CancelBag()
    
    public init(
        userRepository: UserRepositoryType,
        lectureRepository: LectureRepositoryType,
        scheduleRepository: ScheduleRepositoryType,
        sectionRepository: SectionRepositoryType,
        settingRepository: SettingRepositoryType,
        timeTableRepository: TimeTableRepositoryType
    ) {
        self.userRepository = userRepository
        self.lectureRepository = lectureRepository
        self.scheduleRepository = scheduleRepository
        self.sectionRepository = sectionRepository
        self.settingRepository = settingRepository
        self.timeTableRepository = timeTableRepository
    }
    
    public var tableId: Int = 0
    public var errMessage = PassthroughSubject<String, Never>()
    public var timeTableInfo = PassthroughSubject<TimeTableInfo, Never>()
    public var sectionList = PassthroughSubject<[SectionInfo], Never>()
    public var displayInfo = PassthroughSubject<DisplayTypeInfo, Never>()
}

//MARK: Main
extension TimeTableUseCase {
    // 시간표 상세조회 불러오기
    
    public func fetchTableInfo() -> AnyPublisher<Void, Never> {
        getTableId()
            .filter { $0 != nil}
            .map { $0! }
            .handleEvents(receiveOutput: { [weak self] id in
                self?.tableId = id
            })
            .map { _ in }
            .flatMap(getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    public func getProfileInfo() -> AnyPublisher<ProfileInfo, Never> {
        userRepository.getProfile()
            .catch { _ in  Empty() }
            .eraseToAnyPublisher()
    }
    
    
    public func getTableDetailInfo() -> AnyPublisher<Void, Never> {
        timeTableRepository.getTableDetailInfo(tableId)
            .handleEvents(receiveOutput: { [weak self] detailInfo in
                self?.timeTableInfo.send(detailInfo.tableInfo)
                self?.displayInfo.send(detailInfo.tableInfo.displayType!)
                self?.sectionList.send(detailInfo.sectionList)
            })
            .map { _ in }
            .catch {  _ in Empty() }
            .eraseToAnyPublisher()
    }
    
    public func getTableId() -> AnyPublisher<Int?, Never> {
        timeTableRepository.getTableList()
            .flatMap { tableId -> AnyPublisher<Int?, Never> in
                if let tableId = tableId {
                    return Just(tableId)
                        .eraseToAnyPublisher()
                } else {
                    return self.timeTableRepository.postTable()
                        .map {
                            return $0
                        }
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
    
    public func addSection(_ sectionId: Int) -> AnyPublisher<Void, Never> {
        return sectionRepository.addSection(tableId, sectionId, "")
            .catch { [weak self] error in
                self?.errMessage.send(error.description)
                return Empty<Void, Never>()
            }
            .flatMap(getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    public func deleteSection(_ isCustom: Bool, _ sectionId: Int) -> AnyPublisher<Void, Never> {
        if isCustom {
            return scheduleRepository.deleteLectureModule(tableId, sectionId)
                .catch { _ in Empty() }
                .flatMap(getTableDetailInfo)
                .eraseToAnyPublisher()
        } else {
            return sectionRepository.deleteSection(tableId, sectionId)
                .catch { _ in Empty() }
                .flatMap(getTableDetailInfo)
                .eraseToAnyPublisher()
        }
    }
}

//MARK: Serach
extension TimeTableUseCase {
    public func getLectureList(_ keyword: String) -> AnyPublisher<[SectionInfo], Never> {
        if keyword != "" {
            lectureRepository.getLectureListWithKeyword(keyword)
                .catch { _ in
                    return Just([]).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        } else {
            lectureRepository.getLectureList()
                .catch { _ in
                    return Just([]).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        }
    }
    
    public func addCustomModule(
        _ customModule: CustomModuleInfo
    ) -> AnyPublisher<Void, Never> {
        return scheduleRepository.addCustomModule(tableId, customModule)
            .catch { [weak self] error in
                self?.errMessage.send(error.description)
                return Empty<Void, Never>()
            }
            .flatMap(getTableDetailInfo)
            .eraseToAnyPublisher()
    }
}

//MARK: Setting
extension TimeTableUseCase {
    public func changeTimeTableName(_ name: String) -> AnyPublisher<Void, Never> {
        return timeTableRepository.patchTableName(tableId, name)
            .catch { _ in Empty() }
            .flatMap(getTableDetailInfo)
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
    
    public func patchSettingInfo(_ displayType: DisplayTypeInfo, _ theme: String) -> AnyPublisher<Void, Never> {
        return settingRepository.patchTimeTableSettingInfo(displayType, theme)
            .catch { _ in Empty() }
            .eraseToAnyPublisher()
    }
    
    public func deleteAllSection() -> AnyPublisher<Void, Never> {
        return sectionRepository.deleteAllSection(tableId)
            .catch { _ in Empty() }
            .flatMap(getTableDetailInfo)
            .eraseToAnyPublisher()
    }
}

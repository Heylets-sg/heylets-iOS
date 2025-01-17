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
//    public func deleteSection(_ sectionId: String) -> AnyPublisher<Void, Never> {
//        <#code#>
//    }
    
    private let userRepository: UserRepositoryType
    private let lectureRepository: LectureRepositoryType
    private let scheduleRepository: ScheduleRepositoryType
    private let sectionRepository: SectionRepositoryType
    private let themeRepository: ThemeRepositoryType
    private let timeTableRepository: TimeTableRepositoryType
    
    private var cancelBag = CancelBag()
    
    public init(
        userRepository: UserRepositoryType,
        lectureRepository: LectureRepositoryType,
        scheduleRepository: ScheduleRepositoryType,
        sectionRepository: SectionRepositoryType,
        themeRepository: ThemeRepositoryType,
        timeTableRepository: TimeTableRepositoryType
    ) {
        self.userRepository = userRepository
        self.lectureRepository = lectureRepository
        self.scheduleRepository = scheduleRepository
        self.sectionRepository = sectionRepository
        self.themeRepository = themeRepository
        self.timeTableRepository = timeTableRepository
    }
    
    public var tableId: String = ""
    public var timeTableInfo = PassthroughSubject<TimeTableInfo, Never>()
    public var timeTableCellInfo = PassthroughSubject<[TimeTableCellInfo], Never>()
}

//MARK: Main
extension TimeTableUseCase {
    // 시간표 상세조회 불러오기
    
    public func fetchTableInfo() -> AnyPublisher<[SectionInfo], Never> {
        getTableId()
            .filter { $0 != nil}
            .map { "\($0!)"}
            .handleEvents(receiveOutput: { [weak self] id in
                self?.tableId = id
            })
            .flatMap(getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    
    public func getTableDetailInfo(
        _ tableId: String
    ) -> AnyPublisher<[SectionInfo], Never> {
        timeTableRepository.getTableDetailInfo(tableId)
            .handleEvents(receiveOutput: { [weak self] detailInfo in
                self?.timeTableInfo.send(detailInfo.tableInfo)
                self?.timeTableCellInfo.send(detailInfo.sectionList.createTimeTableCellList())
            })
            .map { $0.sectionList } // -> 성공을 위해서???
            .catch {  _ in
                //TODO: 실패처리
                return Just([]).eraseToAnyPublisher()
            }
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
            .catch { _ in
                //TODO: 커스텀 모듈 추가 실패 처리
                return Just(()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
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
        return scheduleRepository.addCustomModule(
            tableId, customModule)
        .catch { _ in
            //TODO: 커스텀 모듈 추가 실패 처리
            return Just(()).eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}

//MARK: Setting
extension TimeTableUseCase {
    public func changeTimeTableName(_ name: String) -> AnyPublisher<Void, Never> {
        return timeTableRepository.patchTableName(tableId, name)
            .catch { _ in
                //TODO: 실패 관련 처리
                return Just(()).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func getThemeList() -> AnyPublisher<[Theme], Never> {
        return themeRepository.getThemeList()
            .catch { _ in
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}

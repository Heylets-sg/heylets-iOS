//
//  StubTimeTableUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

final public class StubTimeTableUseCase: TimeTableUseCaseType {
    public var tableId: Int = 0
    public var errMessage = PassthroughSubject<String, Never>()
    public var guestModeError = PassthroughSubject<Void, Never>()
    public var timeTableInfo = CurrentValueSubject<TimeTableInfo, Never>(.empty)
    public var sectionList = PassthroughSubject<[SectionInfo], Never>()
    public var displayInfo = PassthroughSubject<DisplayTypeInfo, Never>()
    public var profileInfo = CurrentValueSubject<ProfileInfo, Never>(.empty)
    
    public init() {
        timeTableInfo.send(TimeTableInfo.stub)
        sectionList.send([
            .timetable_stub1,
            .timetable_stub2,
            .timetable_stub3,
            .timetable_stub4
        ])
    }
}

//MARK: Main
extension StubTimeTableUseCase {
    // 시간표 상세조회 불러오기
    
    public func fetchTableInfo() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func getProfileInfo() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    
    public func getTableDetailInfo() -> AnyPublisher<Void, Never> {
        timeTableInfo.send(TimeTableInfo.stub)
        return Just(()).eraseToAnyPublisher()
    }
    
    public func getTableId() -> AnyPublisher<Int?, Never> {
        Just(91).eraseToAnyPublisher()
    }
    
    public func addSection(_ sectionId: Int) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func deleteSection(_ isCustom: Bool, _ sectionId: Int) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func getLectureList(_ keyword: String) -> AnyPublisher<[SectionInfo], Never> {
        Just([]).eraseToAnyPublisher()
    }
    
    public func addCustomModule(
        _ customModule: CustomModuleInfo
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func changeTimeTableName(_ name: String) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func getThemeList() -> AnyPublisher<[Theme], Never> {
        Just([]).eraseToAnyPublisher()
    }
    
    public func getThemeDetailInfo(_ themeName: String) -> AnyPublisher<[String], Never> {
        Just([]).eraseToAnyPublisher()
    }
    
    public func getSettingInfo() -> AnyPublisher<SettingInfo, Never> {
        Just(.init(displayType: .MODULE_CODE, theme: "")).eraseToAnyPublisher()
    }
    
    public func patchSettingInfo(
        _ displayType: DisplayTypeInfo,
        _ theme: String
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func deleteAllSection() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func handleInviteCodeView() -> AnyPublisher<Bool, Never> {
        return Just(false).eraseToAnyPublisher()
    }
    
    public func getLectureDepartment() -> AnyPublisher<[String], Never> {
        Just([]).eraseToAnyPublisher()
    }
}


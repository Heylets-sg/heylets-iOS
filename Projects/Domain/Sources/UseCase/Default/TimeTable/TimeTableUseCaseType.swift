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
    var tableId: Int { get }
    var errMessage: PassthroughSubject<String, Never> { get }
    var guestModeError: PassthroughSubject<Void, Never> { get }
    
    //MARK: Main
    
    //시간표 상세조회 불러오기
    var timeTableInfo: CurrentValueSubject<TimeTableInfo, Never> { get }
    var profileInfo: CurrentValueSubject<ProfileInfo, Never> { get }
    var displayInfo: PassthroughSubject<DisplayTypeInfo, Never> { get }
    var sectionList: PassthroughSubject<[SectionInfo], Never> { get }
    
    func fetchTableInfo() -> AnyPublisher<Void, Never>
    func getProfileInfo() -> AnyPublisher<Void, Never>
    
    
    
    //MARK: Search
    //강의 리스트 조회하기 & 강의 검색하기
    func getLectureList(
        _ filterInfo: FilterInfo
    ) -> AnyPublisher<[SectionInfo], Never>
    //커스텀 모듈 추가하기
    func addCustomModule(_ customModule: CustomModuleInfo) -> AnyPublisher<Void, Never>
    //학과 찾기
    func getLectureDepartment() -> AnyPublisher<[String], Never>
    
    
    //MARK: Detail
    //TODO: 강의 상세 정보 불러오기
    
    
    
    // 강의 삭제하기
    func deleteSection(_ isCustom: Bool, _ sectionId: Int) -> AnyPublisher<Void, Never>

    
    //정규 강의 추가하기
    func addSection(
        _ sectionId: Int,
        _ scheduleIsEmpty: Bool
    ) -> AnyPublisher<Void, Never>
    
    //MARK: Setting
    
    //시간표 이름 바꾸기
    func changeTimeTableName(_ name: String) -> AnyPublisher<Void, Never>
    //테마 선택시 반영되도록 상세 색상 가져오기
    func getThemeDetailInfo(_ themeName: String) -> AnyPublisher<[String], Never>
    //테마 리스트 불러오기
    func getThemeList() -> AnyPublisher<[Theme], Never>
    //테마, display 불러오기
    func getSettingInfo() -> AnyPublisher<SettingInfo, Never>
    
    //테마, display 수정하기
    func patchSettingInfo(_ displayType: DisplayTypeInfo,_ theme: String) -> AnyPublisher<Void, Never>
    
    //시간표 삭제하기
    func deleteAllSection() -> AnyPublisher<Void, Never>
    
    //Invite Code 분기처리
    func handleInviteCodeView() -> AnyPublisher<Bool, Never>
}

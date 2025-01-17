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
    var tableId: String { get }
    //MARK: Main
    
    //시간표 상세조회 불러오기
    var timeTableInfo: PassthroughSubject<TimeTableInfo, Never> { get }
    var timeTableCellInfo: PassthroughSubject<[TimeTableCellInfo], Never> { get }
    
    func fetchTableInfo() -> AnyPublisher<[SectionInfo], Never>
    
    
    
    //MARK: Search
    //강의 리스트 조회하기 & 강의 검색하기
    func getLectureList(_ keyword: String) -> AnyPublisher<[SectionInfo], Never>
    //커스텀 모듈 추가하기
    func addCustomModule(_ customModule: CustomModuleInfo) -> AnyPublisher<Void, Never>
    
    
    //MARK: Detail
    //TODO: 강의 상세 정보 불러오기
    
    
    
    //TODO: 강의 삭제하기
//    func deleteSection(_ sectionId: String) -> AnyPublisher<Void, Never>
    //TODO: 강의 삭제하기 실패 처리

    
    
    
    //정규 강의 추가하기
    func addSection(_ sectionId: Int) -> AnyPublisher<Void, Never>
    //TODO: 정규 강의 추가하기 실패 처리
    
    //MARK: Setting
    //시간표 이름 바꾸기
    func changeTimeTableName(_ name: String) -> AnyPublisher<Void, Never>
    //테마 리스트 불러오기
    func getThemeList() -> AnyPublisher<[Theme], Never>
    
    
    //TODO: Setting 값 저장하기
    //TODO: 시간표 삭제하기
}

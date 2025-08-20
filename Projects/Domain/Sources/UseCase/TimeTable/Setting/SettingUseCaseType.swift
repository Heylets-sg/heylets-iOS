//
//  SettingUseCaseType.swift
//  Domain
//
//  Created by 류희재 on 8/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine

public protocol SettingUseCaseType {
    //시간표 이름 바꾸기
    func changeTimeTableName(_ name: String) -> AnyPublisher<Void, Never>
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
    // 테마 상세 불러오기
    func getThemeDetailInfo(_ themeName: String) -> AnyPublisher<[String], Never>
}

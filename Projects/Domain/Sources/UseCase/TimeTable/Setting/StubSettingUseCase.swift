//
//  StubSettingUseCase.swift
//  Domain
//
//  Created by 류희재 on 8/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine

final public class StubSettingUseCase: SettingUseCaseType {
    public func changeTimeTableName(_ name: String) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func getThemeList() -> AnyPublisher<[Theme], Never> {
        Just([]).eraseToAnyPublisher()
    }
    
    public func getSettingInfo() -> AnyPublisher<SettingInfo, Never> {
        Just(.init(displayType: .MODULE_CODE, theme: "")).eraseToAnyPublisher()
    }
    
    public func patchSettingInfo(_ displayType: DisplayTypeInfo, _ theme: String) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func deleteAllSection() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func handleInviteCodeView() -> AnyPublisher<Bool, Never> {
        Just(true).eraseToAnyPublisher()
    }
    
    public func getThemeDetailInfo(_ themeName: String) -> AnyPublisher<[String], Never> {
        Just([]).eraseToAnyPublisher()
    }
}

//
//  TimeTableSettingUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

//import Core

//MARK: Setting
public extension TimeTableUseCase {
    func changeTimeTableName(_ name: String) -> AnyPublisher<Void, Never> {
        return timeTableRepository.patchTableName(tableId, name)
            .catch { [weak self] error in
                if error.isGuestModeError { self?.guestModeError.send(()) }
                else { self?.errMessage.send(error.description) }
                return Empty<Void, Never>()
            }
            .flatMap(getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    func getThemeDetailInfo(_ themeName: String) -> AnyPublisher<[String], Never> {
        return settingRepository.getThemeDetailInfo(themeName)
            .map { [$0.defaultColor] + $0.core + $0.gradient}
            .catch { _ in
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func getThemeList() -> AnyPublisher<[Theme], Never> {
        return settingRepository.getThemeList()
            .catch { _ in
                return Just([]).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func getSettingInfo() -> AnyPublisher<SettingInfo, Never> {
        return settingRepository.getTimeTableSettingInfo()
            .catch { _ in Empty() }
            .eraseToAnyPublisher()
    }
    
    func patchSettingInfo(
        _ displayType: DisplayTypeInfo,
        _ theme: String
    ) -> AnyPublisher<Void, Never> {
        return settingRepository.patchTimeTableSettingInfo(displayType, theme)
            .catch { [weak self] error in
                if error.isGuestModeError { self?.guestModeError.send(()) }
                else { self?.errMessage.send(error.description) }
                return Empty<Void, Never>()
            }
            .flatMap(getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    func deleteAllSection() -> AnyPublisher<Void, Never> {
        return sectionRepository.deleteAllSection(tableId)
            .catch { [weak self] error in
                self?.errMessage.send(error.description)
                return Empty<Void, Never>()
            }
            .flatMap(getTableDetailInfo)
            .eraseToAnyPublisher()
    }
}

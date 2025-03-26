//
//  SearchModuleUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import Core

//MARK: Serach
public extension TimeTableUseCase {
    func getLectureList(_ keyword: String) -> AnyPublisher<[SectionInfo], Never> {
        if keyword != "" {
            return lectureRepository.getLectureListWithKeyword(keyword)
                .catch { _ in
                    return Just([]).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        } else {
            Analytics.shared.track(.clickSearchModule(
                keyword: keyword,
                semester: timeTableInfo.value.semester
            )
            )
            return lectureRepository.getLectureList()
                .catch { _ in
                    return Just([]).eraseToAnyPublisher()
                }
                .eraseToAnyPublisher()
        }
    }
    
    func addCustomModule(
        _ customModule: CustomModuleInfo
    ) -> AnyPublisher<Void, Never> {
        return scheduleRepository.addCustomModule(tableId, customModule)
            .catch { [weak self] error in
                if error.isGuestModeError { self?.guestModeError.send(()) }
                else { self?.errMessage.send(error.description) }
                return Empty<Void, Never>()
            }
            .flatMap(getTableDetailInfo)
            .eraseToAnyPublisher()
    }
    
    func getLectureDepartment() -> AnyPublisher<[String], Never> {
        lectureRepository.getLectureDepartment(profileInfo.value.university.rawValue)
            .map { $0 }
            .catch {  _ in Empty<[String], Never>() }
            .eraseToAnyPublisher()
    }
}

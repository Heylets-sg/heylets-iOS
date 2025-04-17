//
//  TimeTableMainUseCase.swift
//  Domain
//
//  Created by 류희재 on 3/23/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public extension TimeTableUseCase {
    // 시간표 상세조회 불러오기
    
    func fetchTableInfo() -> AnyPublisher<Void, Never> {
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
    
    func getProfileInfo() -> AnyPublisher<Void, Never> {
        userRepository.getProfile()
            .handleEvents(receiveOutput: { [weak self] profileInfo in
                self?.profileInfo.send(profileInfo)
            })
            .map { _ in }
            .catch {  _ in Empty() }
            .eraseToAnyPublisher()
    }
    
    
    func getTableDetailInfo() -> AnyPublisher<Void, Never> {
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
    
    func getTableId() -> AnyPublisher<Int?, Never> {
        timeTableRepository.getTableList()
            .flatMap { tableId -> AnyPublisher<Int?, Never> in
                if let tableId = tableId {
                    return Just(tableId)
                        .eraseToAnyPublisher()
                } else {
                    return self.timeTableRepository.postTable()
                        .map { $0 }
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
    
    func addSection(_ sectionId: Int, _ name: String, _ scheduleIsEmpty: Bool) -> AnyPublisher<Void, Never> {
        if scheduleIsEmpty {
            emptyScheduleError.send(name)
            return Empty<Void, Never>()
                .eraseToAnyPublisher()
        } else {
            return sectionRepository.addSection(tableId, sectionId, "")
                .catch { [weak self] error in
                    if error.isGuestModeError { self?.guestModeError.send(()) }
                    else { self?.errMessage.send(error.description) }
                    return Empty<Void, Never>()
                }
                .flatMap(getTableDetailInfo)
                .eraseToAnyPublisher()
        }
        
    }
    
    func deleteSection(_ isCustom: Bool, _ sectionId: Int) -> AnyPublisher<Void, Never> {
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

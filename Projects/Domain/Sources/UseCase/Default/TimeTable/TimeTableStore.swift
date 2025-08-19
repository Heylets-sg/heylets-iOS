//
//  TimeTableCoreUseCase.swift
//  Domain
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

public enum TimeTableError {
    case error(String)
    case guestModeError
    case emptyScheduleError(String)
}

public protocol TimeTableStoreType {
    var tableId: Int { get set }
    
    
    var timeTableDetailInfo: PassthroughSubject<TimeTableDetailInfo, Never> { get }
    var profileInfo: CurrentValueSubject<ProfileInfo, Never> { get }
    var timeTableError: PassthroughSubject<TimeTableError, Never> { get }
    func getTableDetailInfo() -> AnyPublisher<Void, Never>
}

final public class TimeTableStore: TimeTableStoreType {
    public let timeTableRepository: TimeTableRepositoryType
    
    private var cancelBag = CancelBag()
    
    public init(
        timeTableRepository: TimeTableRepositoryType,
    ) {
        self.timeTableRepository = timeTableRepository
    }
    
    public var tableId: Int = 0
    public var timeTableError = PassthroughSubject<TimeTableError, Never>()
    public var timeTableDetailInfo = PassthroughSubject<TimeTableDetailInfo, Never>()
    public var profileInfo = CurrentValueSubject<ProfileInfo, Never>(.empty)
    
    public func getTableDetailInfo() -> AnyPublisher<Void, Never> {
        return timeTableRepository.getTableDetailInfo(tableId)
            .handleEvents(receiveOutput: { [weak self] detailInfo in
                self?.timeTableDetailInfo.send(detailInfo)
            })
            .map { _ in }
            .catch {  _ in Empty() }
            .eraseToAnyPublisher()
    }
}

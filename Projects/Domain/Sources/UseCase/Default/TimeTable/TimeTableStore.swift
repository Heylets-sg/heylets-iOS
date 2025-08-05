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

public protocol TimeTableStoreType {
    var tableId: Int { get set }
    
    var timeTableInfo: CurrentValueSubject<TimeTableInfo, Never> { get }
    var sectionList: PassthroughSubject<[SectionInfo], Never> { get }
    var displayInfo: PassthroughSubject<DisplayTypeInfo, Never> { get }
    var profileInfo: CurrentValueSubject<ProfileInfo, Never> { get }
    
    var errMessage: PassthroughSubject<String, Never> { get }
    var emptyScheduleError: PassthroughSubject<String, Never> { get }
    var guestModeError: PassthroughSubject<Void, Never> { get }
    
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
    public var errMessage = PassthroughSubject<String, Never>()
    public var emptyScheduleError = PassthroughSubject<String, Never>()
    public var guestModeError = PassthroughSubject<Void, Never>()
    public var timeTableInfo = CurrentValueSubject<TimeTableInfo, Never>(.empty)
    public var sectionList = PassthroughSubject<[SectionInfo], Never>()
    public var displayInfo = PassthroughSubject<DisplayTypeInfo, Never>()
    public var profileInfo = CurrentValueSubject<ProfileInfo, Never>(.empty)
    
    public func getTableDetailInfo() -> AnyPublisher<Void, Never> {
        return timeTableRepository.getTableDetailInfo(tableId)
            .handleEvents(receiveOutput: { [weak self] detailInfo in
                self?.timeTableInfo.send(detailInfo.tableInfo)
                self?.displayInfo.send(detailInfo.tableInfo.displayType!)
                self?.sectionList.send(detailInfo.sectionList)
            })
            .map { _ in }
            .catch {  _ in Empty() }
            .eraseToAnyPublisher()
    }
}

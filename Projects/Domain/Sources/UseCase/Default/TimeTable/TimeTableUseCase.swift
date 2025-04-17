//
//  TimeTableUseCase.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

final public class TimeTableUseCase: TimeTableUseCaseType {
    
    public let userRepository: UserRepositoryType
    public let lectureRepository: LectureRepositoryType
    public let scheduleRepository: ScheduleRepositoryType
    public let sectionRepository: SectionRepositoryType
    public let settingRepository: SettingRepositoryType
    public let timeTableRepository: TimeTableRepositoryType
    public let guestRepository: GuestRepositoryType
    
    private var cancelBag = CancelBag()
    
    public init(
        userRepository: UserRepositoryType,
        lectureRepository: LectureRepositoryType,
        scheduleRepository: ScheduleRepositoryType,
        sectionRepository: SectionRepositoryType,
        settingRepository: SettingRepositoryType,
        timeTableRepository: TimeTableRepositoryType,
        guestRepository: GuestRepositoryType
    ) {
        self.userRepository = userRepository
        self.lectureRepository = lectureRepository
        self.scheduleRepository = scheduleRepository
        self.sectionRepository = sectionRepository
        self.settingRepository = settingRepository
        self.timeTableRepository = timeTableRepository
        self.guestRepository = guestRepository
    }
    
    public var tableId: Int = 0
    public var errMessage = PassthroughSubject<String, Never>()
    public var emptyScheduleError = PassthroughSubject<String, Never>()
    public var guestModeError = PassthroughSubject<Void, Never>()
    public var timeTableInfo = CurrentValueSubject<TimeTableInfo, Never>(.empty)
    public var sectionList = PassthroughSubject<[SectionInfo], Never>()
    public var displayInfo = PassthroughSubject<DisplayTypeInfo, Never>()
    public var profileInfo = CurrentValueSubject<ProfileInfo, Never>(.empty)
}

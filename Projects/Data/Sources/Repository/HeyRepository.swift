//
//  Reposiotry.swift
//  Data
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain
import Networks

public class HeyRepository: RepositoryType {
    let service: ServiceType
    
    public var authRepository: AuthRepositoryType
    public var timeTableRepository: TimeTableRepositoryType
    public var settingRepository: SettingRepositoryType
    public var sectionRepository: SectionRepositoryType
    public var scheduleRepository: ScheduleRepositoryType
    public var lectureRepository: LectureRepositoryType
    public var userRepository: UserRepositoryType
    public var guestRepository: GuestRepositoryType
    public var todoRepository: TodoRepositoryType
    public var referralRepository: ReferralRepositoryType
    
    public init(service: ServiceType) {
        self.service = service
        
        authRepository = AuthRepository(
            authService: service.authService
        )
        timeTableRepository = TimeTableRepository(
            service: service.timeTableService
        )
        settingRepository = SettingRepository(
            service: service.themeService
        )
        sectionRepository =  SectionRepository(
            service: service.sectionService
        )
        scheduleRepository = ScheduleRepository(
            service: service.scheduleService
        )
        lectureRepository = LectureRepository(
            service: service.lectureService
        )
        userRepository = UserRepository(
            service: service.userService
        )
        guestRepository = GuestRepository(
            userService: service.userService,
            guestService: service.guestService
        )
        
        todoRepository = TodoRepository(
            service: service.todoService
        )
        
        referralRepository = ReferralRepository(
            service: service.referralService
        )
    }
}

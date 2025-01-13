//
//  ServiceType.swift
//  Networks
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

protocol ServiceType {
//    var appService: AppServiceType { get }
    var authService: AuthServiceType { get }
    var timeTableService: TimeTableServiceType { get }
    var themeService: ThemeServiceType { get }
    var sectionService: SectionServiceType { get }
    var scheduleService: ScheduleServiceType { get }
    var lectureService: LectureServiceType { get }
    var userService: UserServiceType { get }
    
}

final class Service: ServiceType {
//    var appService: AppServiceType = AppService()
    var authService: AuthServiceType = AuthService()
    var timeTableService: TimeTableServiceType = TimeTableService()
    var themeService: ThemeServiceType = ThemeService()
    var sectionService: SectionServiceType = SectionService()
    var scheduleService: ScheduleServiceType = ScheduleService()
    var lectureService: LectureServiceType = LectureService()
    var userService: UserServiceType = UserService()
    
}


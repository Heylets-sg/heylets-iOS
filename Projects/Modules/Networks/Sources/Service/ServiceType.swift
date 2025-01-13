//
//  ServiceType.swift
//  Networks
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

public protocol ServiceType {
//    var appService: AppServiceType { get }
    var authService: AuthServiceType { get }
    var timeTableService: TimeTableServiceType { get }
    var themeService: ThemeServiceType { get }
    var sectionService: SectionServiceType { get }
    var scheduleService: ScheduleServiceType { get }
    var lectureService: LectureServiceType { get }
    var userService: UserServiceType { get }
    
}

final public class HeyService: ServiceType {
    public init() {}
//    var appService: AppServiceType = AppService()
    public var authService: AuthServiceType = AuthService()
    public var timeTableService: TimeTableServiceType = TimeTableService()
    public var themeService: ThemeServiceType = ThemeService()
    public var sectionService: SectionServiceType = SectionService()
    public var scheduleService: ScheduleServiceType = ScheduleService()
    public var lectureService: LectureServiceType = LectureService()
    public var userService: UserServiceType = UserService()
    
}


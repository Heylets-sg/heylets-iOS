//
//  RepositoryType.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public protocol RepositoryType {
//    var appService: AppServiceType { get }
    var authRepository: AuthRepositoryType { get }
    var timeTableRepository: TimeTableRepositoryType { get }
    var themeRepository: ThemeRepositoryType { get }
    var sectionRepository: SectionRepositoryType { get }
    var scheduleRepository: ScheduleRepositoryType { get }
    var lectureRepository: LectureRepositoryType { get }
    var userRepository: UserRepositoryType { get }
}

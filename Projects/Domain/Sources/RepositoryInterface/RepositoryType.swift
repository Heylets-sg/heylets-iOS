//
//  RepositoryType.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public protocol RepositoryType {
    var authRepository: AuthRepositoryType { get }
    var timeTableRepository: TimeTableRepositoryType { get }
    var settingRepository: SettingRepositoryType { get }
    var sectionRepository: SectionRepositoryType { get }
    var scheduleRepository: ScheduleRepositoryType { get }
    var lectureRepository: LectureRepositoryType { get }
    var userRepository: UserRepositoryType { get }
    var guestRepository: GuestRepositoryType { get }
    var todoRepository: TodoRepositoryType { get }
    var referralRepository: ReferralRepositoryType { get }
    var notificationRepository: NotificationRepositoryType { get }
}

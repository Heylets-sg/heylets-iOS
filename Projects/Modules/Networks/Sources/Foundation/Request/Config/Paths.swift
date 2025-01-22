//
//  Paths.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum Paths {
    private static let basePath = "/api/v1" // 공통 경로
    
    //MARK: Auth
    
    static let checkUserName = "api/v1/auth/username/check"
    static let refreshToken = "api/v1/auth/token/refresh"
    static let signUp = "api/v1/auth/signup"
    static let resetPassword = "api/v1/auth/password/reset"
    static let verifyResetPassword = "api/v1/auth/password/reset/verify"
    static let requestResetPassword = "api/v1/auth/password/reset/request"
    static let logout = "api/v1/auth/logout"
    static let login = "api/v1/auth/login"
    static let verifyEmail = "api/v1/auth/email/verify"
    static let requestVerifyEmail = "api/v1/auth/email/verification"
    static let deleteAccount = "api/v1/users/security/me/withdrawal"
    
    //MARK: Lecture
    
    static let getDetailLectureInfo = "api/v1/lectures/{lectureId}"
    static let getLectureList = "api/v1/lectures/search"
    
    //MARK: Schedules

    
    static let deleteLectureModule = "api/v1/timetables/{tableId}/lectures/{scheduleId}"
    static let patchCustomModule = "api/v1/timetables/{tableId}/lectures/custom/{scheduleId}"
    static let addLectureModule = "api/v1/timetables/{tableId}/lectures"
    static let addCustomLectureModule = "api/v1/timetables/{tableId}/lectures/custom"
    
    //MARK: Sections
    
    static let deleteAllSection = "api/v1/timetables/{tableId}/sections"
    static let deleteLectureSection = "api/v1/timetables/{tableId}/sections/{sectionId}"
    static let addLectureSection = "api/v1/timetables/{tableId}/sections"
    
    //MARK: Setting
    
    static let getThemeDetailInfo = "api/v1/timetables/themes/{themeName}"
    static let getPreviewTheme = "api/v1/timetables/themes/preview"
    static let getTimeTableSetting = "api/v1/users/preferences/timetable-settings"
    static let patchTimeTableSetting = "api/v1/users/preferences/timetable-settings"
    
    //MARK: TimeTable
    
    static let deleteTable = "api/v1/timetables/{tableId}"
    static let getTableList = "api/v1/timetables"
    static let getTableDetailInfo = "api/v1/timetables/{tableId}"
    static let patchTable = "api/v1/timetables/{tableId}"
    static let postTable = "api/v1/timetables"
    
    //MARK: My
    
    static let deleteProfileImg = "api/v1/users/profile/me/profile-image"
    static let getProfile = "api/v1/users/profile/me"
    static let patchNickName = "api/v1/users/profile/me/nickname"
    static let patchAcademicInfo = "api/v1/users/profile/me/academic-info"
    static let postProfileImg = "api/v1/users/profile/me/profile-image"
}

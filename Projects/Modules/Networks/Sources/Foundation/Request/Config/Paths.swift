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
    
    static let checkUserName = "api/v1/auth/username/check" //webHook
    static let refreshToken = "api/v1/auth/token/refresh"
    static let signUp = "api/v1/auth/signup" //webHook
    static let resetPassword = "api/v1/auth/password/reset" //webHook
    static let verifyResetPassword = "api/v1/auth/password/reset/verify" //webHook
    static let requestResetPassword = "api/v1/auth/password/reset/request" //webHook
    static let logout = "api/v1/auth/logout" //webHook
    static let login = "api/v1/auth/login" //webHook
    static let verifyEmail = "api/v1/auth/email/verify" //webHook
    static let requestVerifyEmail = "api/v1/auth/email/verification" //webHook
    static let deleteAccount = "api/v1/users/security/me/withdrawal" //webHook
    
    //MARK: Guest
    
    static let changeGuestUniversity = "api/v1/auth/guest/university"
    static let startGuestMode = "api/v2/auth/guest/start/{university}"
    static let convertToMember = "/api/v1/auth/guest/signup" //webHook
    
    
    //MARK: Lecture
    
    static let getDetailLectureInfo = "api/v1/lectures/{lectureId}"
    static let getLectureList = "api/v1/lectures/search"
    static let getLectureDepartment = "api/v1/lectures/university/{university}/departments"
    static let getKeyword = "api/v1/lectures/keywords"
    
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
    
    //MARK: TODO
    
    static let deleteItem = "api/v1/todos/items/{itemId}"
    static let deleteGroup = "api/v1/todos/groups/{groupId}"
    static let getGroup = "api/v1/todos/{timeTableId}"
    static let editItem = "api/v1/todos/items/{itemId}"
    static let toggleItemCompleted = "api/v1/todos/items/{itemId}/toggle"
    static let editGroupName = "api/v1/todos/groups/{groupId}/name"
    static let createGroup = "api/v1/todos/groups"
    static let createItem = "api/v1/todos/groups/{groupId}/items"
    
    
    //MARK: Test
    
    static let testSignUp = "api/v1/admin/auth/signup/test"
    static let testGuestSignUp = "api/v1/admin/auth/guest/signup/test"
    
    
    //MARK: Referral
    
    static let getReferralCode = "api/v1/referrals/my-code"
    static let validateReferralCode = "api/v1/referrals/validate"
    
    //MARK: Notification
    static let notificationSetting = "api/v1/notifications/settings"
    
    
}

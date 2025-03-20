//
//  TimeTableViewType.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum TimeTableViewType: String, Equatable {
    case main = "timetable"
    case detail = "module_info"
    case search = "add_module"
    case setting = "timetable_setting"
    case theme = "timetable_theme"
    case addCustom = "add_custom_module"
}

public enum TimeTableSettingAlertType: String {
    case editTimeTableName = "change_timetable_name"
    case shareURL = ""
    case saveImage = "save_image"
    case removeTimeTable = "remove_all_modules"
}

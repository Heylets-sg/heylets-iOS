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
    case shareURL = "share_URL"
    case saveImage = "save_image"
    case removeTimeTable = "remove_all_modules"
}


/// ViewType별 overlay dimmed 적용
struct OverlayConfiguration {
    let shouldShow: Bool
    let opacity: Double
    
    static func configure(viewType: TimeTableViewType, isThemeSelectInfoShowing: Bool) -> OverlayConfiguration {
        let shouldShow: Bool
        let opacity: Double
        
        switch viewType {
        case .main, .search:
            shouldShow = false
            opacity = 0
        case .theme:
            shouldShow = isThemeSelectInfoShowing
            opacity = isThemeSelectInfoShowing ? 1.0 : 0.0
        case .detail, .setting:
            shouldShow = true
            opacity = 1.0
        case .addCustom:
            shouldShow = true
            opacity = 0.0
        }
        
        return OverlayConfiguration(shouldShow: shouldShow, opacity: opacity)
    }
}


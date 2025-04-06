//
//  TimeTableViewType.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

public enum TimeTableViewType: String, Equatable {
    case main = "timetable"
    case detail = "module_info"
    case search = "add_module"
    case setting = "timetable_setting"
    case theme = "timetable_theme"
    case addCustom = "add_custom_module"
    
    var topViewTopPadding: Int {
        switch self {
        case .main:
            return 67
        case .theme:
            return 46
        default:
            return 59
        }
    }

    var topViewBottomPadding: Int {
        switch self {
        case .main,.detail,.setting:
            return 50
        case .theme:
            return 16
        case .search, .addCustom:
            return 33
        }
    }
    
    var topViewHeight: Int {
        switch self {
        case .main, .detail,.setting:
            return 53
        case .search, .addCustom:
            return 18
        case .theme:
            return 21
        }
    }
    
    var bottomSheetHeight: Int {
        switch self {
        case .search, .addCustom: return 506
        case .theme: return 380
        default: return 0
        }
    }
}

public enum TimeTableSettingAlertType: String {
    case editTimeTableName = "change_timetable_name"
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
            opacity = isThemeSelectInfoShowing ? 0.0 : 1.0
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


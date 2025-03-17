//
//  WindowDestination.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum WindowDestination {
    case splash
    case login
    case onboarding
    case timetable
    case todo
    case mypage
}

extension WindowDestination {
    var screenName: String {
        switch self {
        case .splash:
            return "splash"
        case .login:
            return "log_in"
        case .onboarding:
            return "onboarding"
        case .timetable:
            return "timetable"
        case .todo:
            return "todo"
        case .mypage:
            return "my_page"
        }
    }
}

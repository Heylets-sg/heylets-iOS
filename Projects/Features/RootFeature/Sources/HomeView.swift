//
//  HomeView.swift
//  RootFeature
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency
import OnboardingFeature
import TimeTableFeature
import MyPageFeature
import SplashFeature
import TodoFeature
import Domain
import DSKit

import Foundation

/// 메인 탭의 타입
enum MainTabType: String, CaseIterable { // For Each를 위해서 CaseIterable 프로토콜 채택
    case timetable
    case todo
    case mypage
    
    var title: String {
        switch self {
        case .timetable:
            return "Timetable"
        case .todo:
            return "To do"
        case .mypage:
            return "My"
        }
    }
    
    func imageName(selected: Bool) -> UIImage {
        switch self {
        case .timetable:
            return .tabTimeTable
        case .todo:
            return .tabTodo
        case .mypage:
            return .tabMypage
        }
    }
}

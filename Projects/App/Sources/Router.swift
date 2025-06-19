//
//  DIContainer.swift
//  Heylets-iOS
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Domain
import Networks
import Data
import BaseFeatureDependency

extension HeyUseCase {
    @MainActor
    static public let `default` = HeyUseCase(
        repository: HeyRepository(
            service: HeyService()
        )
    )
}

import TimeTableFeature

extension Router {
    func navigateToTimeTableTheme() {
        windowRouter.switch(to: .timetable)
        
        // TimeTableViewTypeService를 사용하여 테마 화면으로 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            TimeTableViewTypeService.shared.switchTo(.theme(true))
        }
    }
}

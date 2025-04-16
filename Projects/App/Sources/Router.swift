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

//
//extension Router {
//    static public let `default` = Router()
//}
//
extension HeyUseCase {
    static public let `default` = HeyUseCase(
        repository: HeyRepository(
            service: HeyService()
        )
    )
}

// Router.swift에 아래 코드를 추가합니다
import TimeTableFeature // TimeTableViewTypeService를 사용하기 위한 import

extension Router {
    func navigateToTimeTableTheme() {
        // 먼저 timetable 탭으로 전환
        windowRouter.switch(to: .timetable)
        
        // TimeTableViewTypeService를 사용하여 테마 화면으로 전환
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            // 탭 전환이 완료된 후 테마 뷰로 전환
            TimeTableViewTypeService.shared.switchTo(.theme)
        }
    }
}

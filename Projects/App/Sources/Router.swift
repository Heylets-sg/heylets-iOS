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


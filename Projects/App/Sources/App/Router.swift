//
//  Router.swift
//  Heylets-iOS
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Combine
import BaseFeatureDependency
import OnboardingFeature

extension Router {
    static let `default` = Router.init(windowRouter: WindowRouter())
//    static let stub = Router.init(navigationRouter: NavigationRouter(), windowRouter: WindowRouter())
}

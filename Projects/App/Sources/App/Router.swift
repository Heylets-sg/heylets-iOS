//
//  Router.swift
//  Heylets-iOS
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Combine
import BaseFeatureDependency
//
//final class Router: RouterType {
//    
//    var navigationRouter: NavigationRoutableType
//    var windowRouter: WindowRoutableType
//    
//    private init(
//        navigationRouter: NavigationRoutableType = NavigationRouter(),
//        windowRouter: WindowRoutableType = WindowRouter()
//    ) {
//        self.navigationRouter = navigationRouter
//        self.windowRouter = windowRouter
//        
//        navigationRouter.setObjectWillChange(objectWillChange)
//        windowRouter.setObjectWillChange(objectWillChange)
//    }
//}

extension Router {
    static let `default` = Router()
    static let stub = Router()
}


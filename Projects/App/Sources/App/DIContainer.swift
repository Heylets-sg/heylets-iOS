////
////  DIContainer.swift
////  Heylets-iOS
////
////  Created by 류희재 on 12/18/24.
////  Copyright © 2024 Heylets-iOS. All rights reserved.
////
//
//import Foundation
//import Core
//
//typealias NavigationRoutableType = NavigationRoutable & ObservableObjectSettable
//typealias WindowRoutableType = WindowRoutable & ObservableObjectSettable
//
//final class DIContainer: ObservableObject {
//    
////    var service: ServiceType
//    var navigationRouter: NavigationRoutableType
//    var windowRouter: WindowRoutableType
//    
//    private init(
////        service: ServiceType,
//        navigationRouter: NavigationRoutableType = NavigationRouter(),
//        windowRouter: WindowRoutableType = WindowRouter()
//    ) {
////        self.service = service
//        self.navigationRouter = navigationRouter
//        self.windowRouter = windowRouter
//        
//        navigationRouter.setObjectWillChange(objectWillChange)
//        windowRouter.setObjectWillChange(objectWillChange)
//    }
//}
//
//extension DIContainer {
//    static let `default` = DIContainer()/*service: Service())*/
//    static let stub = DIContainer()/*service: StubService())*/
//}
//

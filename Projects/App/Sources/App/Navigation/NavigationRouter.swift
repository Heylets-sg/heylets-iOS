////
////  NavigatationRoutable.swift
////  BaseFeatureDependency
////
////  Created by 류희재 on 12/18/24.
////  Copyright © 2024 Heylets-iOS. All rights reserved.
////
//
//import Combine
//
//import Core
//import BaseFeatureDependency
//import OnboardingFeature
//
//final class NavigationRouter: NavigationRoutable, ObservableObjectSettable {
//    var objectWillChange: ObservableObjectPublisher?
//    
//    var destinations: [NavigationDestination] = [] {
//        didSet {
//            objectWillChange?.send()
//        }
//    }
//    
//    func push(to view: NavigationDestination) {
//        destinations.append(view)
//    }
//    
//    func pop() {
//        _ = destinations.popLast()
//    }
//    
//    func popToRootView() {
//        destinations = []
//    }
//}

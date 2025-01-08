//
//  MyPageRouter.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Combine
import Core
import BaseFeatureDependency

final public class MyPageNavigationRouter: MyPageNavigationRoutable, ObservableObject {
    
    @Published public var destinations: [MyPageNavigationDestination] = []
    
    public init() {}
    
    public func push(to view: MyPageNavigationDestination) {
        destinations.append(view)
    }
    
    public func pop() {
        _ = destinations.popLast()
    }
    
    public func popToRootView() {
        destinations = []
    }
}

final public class StubMyPageNavigationRouter: MyPageNavigationRoutable, ObservableObject {
    
    @Published public var destinations: [MyPageNavigationDestination] = []
    
    public init() {}
    
    public func push(to view: MyPageNavigationDestination) {
        destinations.append(view)
    }
    
    public func pop() {
        _ = destinations.popLast()
    }
    
    public func popToRootView() {
        destinations = []
    }
}




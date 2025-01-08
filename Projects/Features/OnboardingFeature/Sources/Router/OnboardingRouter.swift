//
//  OnboardingRouter.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/20/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Combine
import Core
import BaseFeatureDependency

final public class OnboardingNavigationRouter: OnboardingNavigationRoutable, ObservableObject {
    
    @Published public var destinations: [OnboardingNavigationDestination] = []
    
    public init() {}
    
    public func push(to view: OnboardingNavigationDestination) {
        destinations.append(view)
    }
    
    public func pop() {
        _ = destinations.popLast()
    }
    
    public func popToRootView() {
        destinations = []
    }
}

final public class StubOnboardingNavigationRouter: OnboardingNavigationRoutable, ObservableObject {
    
    @Published public var destinations: [OnboardingNavigationDestination] = []
    
    public init() {}
    
    public func push(to view: OnboardingNavigationDestination) {
        destinations.append(view)
    }
    
    public func pop() {
        _ = destinations.popLast()
    }
    
    public func popToRootView() {
        destinations = []
    }
}



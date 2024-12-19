//
//  Router.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation

import Core

public typealias NavigationRoutableType = NavigationRoutable & ObservableObjectSettable
public typealias WindowRoutableType = WindowRoutable & ObservableObjectSettable

public protocol RouterType {
    var navigationRouter: NavigationRoutableType { get }
    var windowRouter: WindowRoutableType { get }
}

final public class Router: RouterType, ObservableObject {
    
    public var navigationRouter: NavigationRoutableType
    public var windowRouter: WindowRoutableType
    
    public init(
        navigationRouter: NavigationRoutableType = NavigationRouter(),
        windowRouter: WindowRoutableType = WindowRouter()
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        
        navigationRouter.setObjectWillChange(objectWillChange)
        windowRouter.setObjectWillChange(objectWillChange)
    }
}

import Combine

import Core
//import BaseFeatureDependency

final public class NavigationRouter: NavigationRoutable, ObservableObjectSettable {
    
    public init() {}
    public var objectWillChange: ObservableObjectPublisher?
    
    public var destinations: [NavigationDestination] = [] {
        didSet {
            objectWillChange?.send()
        }
    }
    
    public func push(to view: NavigationDestination) {
        destinations.append(view)
    }
    
    public func pop() {
        _ = destinations.popLast()
    }
    
    public func popToRootView() {
        destinations = []
    }
    //}
}

import Foundation
import Combine

import Core
import BaseFeatureDependency

final public class WindowRouter: WindowRoutable, ObservableObjectSettable {
    
    public init() {}
    
    public var objectWillChange: ObservableObjectPublisher?
    
    public var destination: WindowDestination = .onboarding {
        didSet {
            objectWillChange?.send()
        }
    }
    
    public func `switch`(to destination: WindowDestination) {
        self.destination = destination
    }
}

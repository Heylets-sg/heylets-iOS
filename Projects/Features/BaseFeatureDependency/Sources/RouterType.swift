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
        navigationRouter: NavigationRoutableType,
        windowRouter: WindowRoutableType
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter

        navigationRouter.setObjectWillChange(objectWillChange)
        windowRouter.setObjectWillChange(objectWillChange)
    }
}


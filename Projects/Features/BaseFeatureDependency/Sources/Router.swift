//
//  DIContainer.swift
//  Heylets-iOS
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

import Core
import Domain


public typealias NavigationRoutableType = NavigationRoutable & ObservableObjectSettable
public typealias WindowRoutableType = WindowRoutable & ObservableObjectSettable

final public class Router: ObservableObject {
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

extension Router {
    static public let `default` = Router()
}



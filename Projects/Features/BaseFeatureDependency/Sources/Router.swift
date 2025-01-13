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

//
//  DIContainerType.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation


public protocol DIContainerType: ObservableObject {
    var useCase: UseCaseType { get }
    var navigationRouter: NavigationRoutableType { get }
    var windowRouter: WindowRoutableType { get }
}

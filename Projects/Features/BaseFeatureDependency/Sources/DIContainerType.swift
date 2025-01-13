//
//  DIContainerType.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Core

public typealias NavigationRoutableType = NavigationRoutable & ObservableObjectSettable
public typealias WindowRoutableType = WindowRoutable & ObservableObjectSettable

//
//  DIContainer.swift
//  Heylets-iOS
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import DSKit

//import RootFeature
import Core




final public class DIContainer: ObservableObject {
    public var navigationRouter: NavigationRoutableType
    public var windowRouter: WindowRoutableType
    
    init(
        navigationRouter: NavigationRoutableType = NavigationRouter(),
        windowRouter: WindowRoutableType = WindowRouter()
    ) {
        self.navigationRouter = navigationRouter
        self.windowRouter = windowRouter
        
        navigationRouter.setObjectWillChange(objectWillChange)
        windowRouter.setObjectWillChange(objectWillChange)
    }
}

extension DIContainer {
    static public let `default` = DIContainer()
}



class NavigationRouter: NavigationRoutable, ObservableObjectSettable {
    public var objectWillChange: ObservableObjectPublisher?
    
    var destinations: [NavigationDestination] = [] {
        didSet {
            objectWillChange?.send()
        }
    }
    
    func push(to view: NavigationDestination) {
        destinations.append(view)
    }
    
    func pop() {
        _ = destinations.popLast()
    }
    
    func popToRootView() {
        destinations = []
    }
}


import Foundation
import Combine

import Core
import BaseFeatureDependency

final class WindowRouter: WindowRoutable, ObservableObjectSettable {
    
    public var objectWillChange: ObservableObjectPublisher?
    
    var destination: WindowDestination = .splash {
        didSet {
            objectWillChange?.send()
        }
    }
    
    func `switch`(to destination: WindowDestination) {
        self.destination = destination
    }
}

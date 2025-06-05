//
//  NavigationRoutable.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

@MainActor
public protocol NavigationRoutable {
    var destinations: [NavigationDestination] { get set }
    
    nonisolated func push(to view: NavigationDestination)
    nonisolated func pop()
    nonisolated func popToRootView()
}

@MainActor
public class NavigationRouter: NavigationRoutable, ObservableObjectSettable {
    public var objectWillChange: ObservableObjectPublisher?
    
    public var destinations: [NavigationDestination] = [] {
        didSet {
            notifyWillChange()
        }
    }
    
    nonisolated public func push(to view: NavigationDestination) {
        Analytics.shared.track(.screenView(view.screenName, .screen))
        Task { @MainActor in
            destinations.append(view)
        }
        
    }
    
    nonisolated public func pop() {
        Task { @MainActor in
            _ = destinations.popLast()
        }
    }
    
    nonisolated public func popToRootView() {
        Task { @MainActor in
            destinations = []
        }
    }
}

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

public protocol NavigationRoutable {
    var destinations: [NavigationDestination] { get set }
    
    func push(to view: NavigationDestination)
    func pop()
    func popToRootView()
}

public class NavigationRouter: NavigationRoutable, ObservableObjectSettable {
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
}

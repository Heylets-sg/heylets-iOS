//
//  WindowRoutable.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

public protocol WindowRoutable {
    var destination: WindowDestination { get }
    func `switch`(to destination: WindowDestination)
}

final public class WindowRouter: WindowRoutable, ObservableObjectSettable {
    
    public init() {}
    
    public var objectWillChange: ObservableObjectPublisher?
    
    public var destination: WindowDestination = .splash {
        didSet {
            objectWillChange?.send()
        }
    }
    
    public func `switch`(to destination: WindowDestination) {
        self.destination = destination
    }
}


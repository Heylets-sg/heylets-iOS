//
//  ViewModelType.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 6/6/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Combine

@MainActor
public protocol ViewModelType: ObservableObject {
    associatedtype State
    associatedtype Action
    
    var state: State { get set }
    
    func send(_ action: Action)
//    func observe()
}

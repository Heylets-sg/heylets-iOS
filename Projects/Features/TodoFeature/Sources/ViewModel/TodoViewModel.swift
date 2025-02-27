//
//  TodoViewModel.swift
//  TodoFeature
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import Core

public class TodoViewModel: ObservableObject {
    
    enum Action {
    }
    
    public var windowRouter: WindowRoutable
    private var cancelBag = CancelBag()
    
    public init(
        windowRouter: WindowRoutableType
    ) {
        self.windowRouter = windowRouter
    }
    
    func send(_ action: Action) {
        switch action {
            
        }
    }
}




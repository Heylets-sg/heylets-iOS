//
//  DIContainer.swift
//  Heylets-iOS
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation

import Core
import BaseFeatureDependency

extension DIContainer {
    static let `default`: DIContainer = {
        let container = DIContainer()
        
        container.register(NavigationRoutableType.self) {
            return NavigationRouter()
        }
        
        container.register(WindowRoutableType.self) {
            return WindowRouter()
        }
        
        return container
    }()
}

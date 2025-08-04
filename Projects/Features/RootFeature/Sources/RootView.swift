//
//  example.swift
//  RootFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//
//
import SwiftUI

import BaseFeatureDependency
import Domain

public struct RootView: View {
    public init() {}
    @EnvironmentObject var router: Router
    @EnvironmentObject var useCase: HeyUseCase
    
    // ViewFactoryManager를 lazy로 초기화
    private var factoryManager: ViewFactoryManager {
        ViewFactoryManager(router: router, useCase: useCase)
    }
    
    public var body: some View {
        factoryManager.createView(for: router.windowRouter.destination)
    }
}

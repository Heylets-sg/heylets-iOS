//
//  Heylets_iOSAPP.swift
//  Heylets-iOS
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import DSKit

import BaseFeatureDependency
import OnboardingFeature
import RootFeature

@main
struct Heylets_iOSAPP: App {
    var navigationRouter: NavigationRoutableType = NavigationRouter()
    var body: some Scene {
        WindowGroup {
            OnboardingView(navigationRouter: <#any NavigationRoutableType#>)
        }
    }
}

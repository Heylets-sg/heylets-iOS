//
//  Heylets_iOSAPP.swift
//  Heylets-iOS
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import DSKit

import RootFeature
import Core
import BaseFeatureDependency

@main
struct Heylets_iOSAPP: App {
    @StateObject var router = Router.default
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
        }
    }
}

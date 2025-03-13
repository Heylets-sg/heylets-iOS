//
//  Heylets_iOSAPP.swift
//  Heylets-iOS
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency
import Domain
import RootFeature

@main
struct Heylets_iOSAPP: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate 
    
    @StateObject var router = Router.default
    @StateObject var useCase = HeyUseCase.default
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
                .environmentObject(useCase)
        }
    }
}

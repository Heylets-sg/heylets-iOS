//
//  SplashView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct SplashView: View {
    
    @EnvironmentObject var router: Router
    
    public init() {}
    
    public var body: some View {
        VStack {
            Text("Splash View")
        }
    }
}

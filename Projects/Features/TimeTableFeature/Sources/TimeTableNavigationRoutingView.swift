//
//  TimeTableNavigationRoutingView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/20/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

import BaseFeatureDependency
import Domain

import Core

struct TimeTableNavigationRoutingView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var useCase: HeyUseCase
    @State var destination: NavigationDestination
    
    var body: some View {
        switch destination {
        
        // Onboarding
        case .timeTable:
            let useCase = useCase.timeTableUseCase
            TimeTableView(
                viewModel: .init(
                    SearchModuleViewModel(useCase),
                    AddCustomModuleViewModel(useCase),
                    ThemeViewModel(useCase, router.navigationRouter),
                    TimeTableSettingViewModel(useCase),
                    router.navigationRouter,
                    router.windowRouter,
                    useCase
                )
            )

        case .inviteCode:
            InviteCodeView(
                viewModel: .init(
                    navigationRouter: router.navigationRouter,
                    useCase: useCase.myPageUseCase
                )
            )
        default:
            EmptyView()
        }
    }
}

extension View {
    public func setTimeTableHeyNavigation() -> some View {
        self.navigationDestination(for: NavigationDestination.self) { destination in
            TimeTableNavigationRoutingView(destination: destination)
        }
    }
}


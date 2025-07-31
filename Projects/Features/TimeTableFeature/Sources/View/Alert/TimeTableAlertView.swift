//
//  TimeTableAlertView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit

extension View {
    func heyAlert(
        _ alert: HeyTimeTableAlertType?,
        viewModel: TimeTableViewModel
    ) -> some View {
        self.overlay {
            if let alert {
                ZStack {
                    Color.common.Background.opacity60
                    
                    HeyAlertView(
                        title: alert.title,
                        primaryAction: alert.primaryAction.convert(on: viewModel),
                        secondaryAction: alert.secondaryAction == nil ? nil : alert.secondaryAction!.convert(on: viewModel)
                    )
                    .padding(.horizontal, 44)
                }
                .ignoresSafeArea()
            }
        }
    }
}

//
//  MissingModuleView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain
import DSKit
import BaseFeatureDependency
import Core

struct MissingModuleView: View {
    var keyword: String
    var onReport: () -> Void
    
    var body: some View {
        Text("We couldn't find a match for\n'\(keyword)'.")
            .font(.regular_16)
            .multilineTextAlignment(.center)
            .foregroundColor(.common.Placeholder.default)
            .padding(.bottom, 20)
            .onAppear {
                Analytics.shared.track(.screenView("missing_module", .modal))
            }
        
        Button {
            onReport()
        } label: {
            HStack {
                Text("Report Missing Modules")
                    .font(.regular_14)
                    .foregroundColor(.common.Placeholder.default)
                
                Image.icNext
                    .resizable()
                    .frame(width: 4, height: 9)
                    .tint(.common.MainText.else)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.common.Placeholder.default, lineWidth: 1)
            )
        }
        
        Spacer()
    }
}

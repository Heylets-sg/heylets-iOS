//
//  EnterPersonalInfoView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency
//import DSKit

public struct EnterPersonalInfoView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: EnterPersonalInfoViewModel
    var genderList: [Gender] = [.men, .women, .others]
    
    @State var date = Date()
    
    public init(viewModel: EnterPersonalInfoViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            HStack(spacing: 16) {
                ForEach(genderList, id: \.self) { gender in
                    GenderButton(
                        title: gender.title,
                        isSelected: gender == viewModel.gender,
                        action: { viewModel.send(.genderButtonDidTap(gender)) }
                    )
                }
            }
            .padding(.trailing, 62)
            .padding(.bottom, 20)
            
            HStack {
                DatePicker(
                    "DatePicker",
                    selection: $viewModel.birth,
                    displayedComponents: [.date]
                )
                .onChange(of: viewModel.birth) { date in
                    viewModel.send(.birthDayDidChange(date))
                }
                .labelsHidden()
            }
        }, titleText: "Please check your gender/birth", nextButtonAction: { viewModel.send(.nextButtonDidTap)
        })
    }
}

fileprivate struct GenderButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .font(.semibold_14)
                .background(isSelected ? Color.heyMain : Color.heyGray4)
                .foregroundStyle(Color.heyBlack)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}


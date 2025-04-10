//
//  SelectUniversityView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit
import Domain

public struct SelectUniversityView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: SelectUniversityViewModel
    @FocusState private var isFocused: Bool
    
    public init(viewModel: SelectUniversityViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(
            content: {
                VStack {
                    HeyTextField(
                        text: $viewModel.searchText,
                        placeHolder: "Select your university",
                        leftImage: .icSchool
                    )
                    .focused($isFocused)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onChange(of: isFocused) { isFocused in
                        if isFocused {
                            viewModel.send(.textFieldDidTap)
                        }
                    }
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(viewModel.state.filteredItems, id: \.self) { university in
                                SelectUniversityListCellView(
                                    university,
                                    isSelected: university == viewModel.university
                                )
                                .onTapGesture {
                                    viewModel.send(.selectUniversity(university))
                                }
                            }
                        }
                        .cornerRadius(8)
                    }
                }
            }, titleText: "What school are you attending?",
            nextButtonIsEnabled: viewModel.state.continueButtonIsEnabled,
            nextButtonAction: { viewModel.send(.nextButtonDidTap) }
        )
        .onTapGesture { isFocused = false }
    }
}


fileprivate struct SelectUniversityListCellView: View {
    private let university: UniversityInfo
    private let isSelected: Bool
    
    init(_ university: UniversityInfo, isSelected: Bool) {
        self.university = university
        self.isSelected = isSelected
    }
    
    var body: some View {
        HStack {
            Image(uiImage: university.icon)
                .resizable()
                .frame(width: 24.adjusted, height: 24.adjusted)
                .padding(.leading, 16)
            
            Text(university.rawValue)
                .font(.regular_14)
                .foregroundColor(
                    isSelected
                    ? .common.TextActive.else
                    : .common.Placeholder.default
                )
                .padding(.leading, 12)
            
            Spacer()
        }
        .padding(.vertical, 10.adjusted)
        .background(
            isSelected
            ? Color.common.Button.active
            : Color.common.InputField.default
        )
    }
}

#Preview {
    SelectUniversityView(
        viewModel: SelectUniversityViewModel(
            navigationRouter: Router.default.navigationRouter,
            useCase: StubHeyUseCase.stub.signUpUseCase
        )
    )
    .environmentObject(Router.default)
    .preferredColorScheme(.dark)
}

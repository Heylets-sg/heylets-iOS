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

import SwiftUI

import DSKit

enum UniversityInfo: String {
    case NUS
    case NTU
    
    var icon: UIImage {
        switch self {
        case .NUS:
            return .nus
        case .NTU:
            return .ntu
        }
    }
}


public struct SelectUniversityView: View {
    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: SelectUniversityViewModel
    
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
                        leftImage: .icSchool,
                        textFieldState: .idle
                    )
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.heyMain, lineWidth: 2)
                    )
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach(viewModel.filteredItems, id: \.self) { university in
                                SelectUniversityListCellView(
                                    university,
                                    isSelected: university.rawValue == viewModel.selectedUniversity
                                )
                                .onTapGesture {
                                    viewModel.send(.selectUniversity(university.rawValue))
                                }
                            }
                        }
                        .cornerRadius(8)
                        
                    }
                }
            }, titleText: "What school are you attending?",
            nextButtonAction: { viewModel.send(.nextButtonDidTap) }
        )
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
                .frame(width: 24, height: 24)
                .padding(.leading, 16)
            
            Text(university.rawValue)
                .font(.regular_14)
                .foregroundColor(.heyGray1)
                .padding(.leading, 12)
            
            Spacer()
        }
        .padding(.vertical, 10)
        .background(isSelected ? Color.heyMain : Color.heyGray4)
    }
}
//#Preview {
//    SelectUniversityView()
//}

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
    var viewModel: SelectUniversityViewModel
    
    @State private var searchText: String = ""
    @State private var selectedUniversity: UniversityInfo?
    
    private let allUniversityItems: [UniversityInfo] = [.NTU, .NUS]
    
    private var filteredItems: [UniversityInfo] {
        if searchText.isEmpty || selectedUniversity != nil {
            return []
        } else {
            return allUniversityItems.filter {
                $0.rawValue.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    public init(viewModel: SelectUniversityViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(
            content: {
                VStack {
                    HeyTextField(
                        text: $searchText,
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
                            ForEach(filteredItems, id: \.self) { university in
                                SelectUniversityListCellView(
                                    university,
                                    isSelected: university == selectedUniversity
                                )
                                .onTapGesture {
                                    selectedUniversity = university
                                    searchText = university.rawValue
                                    viewModel.send(.selectUniversity(university.rawValue))
                                }
                            }
                        }
                        .cornerRadius(8)
                    }
                }
            }, titleText: "What school are you attending?",
            nextButtonAction: { viewModel.send(.nextButtonDidTap)
//            isEnabled: viewModel.state.continueButtonEnabled
            }
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

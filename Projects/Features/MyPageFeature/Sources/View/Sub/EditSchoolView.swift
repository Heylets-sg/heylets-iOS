//
//  EditSchoolView.swift
//  MyPageFeature
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

struct EditSchoolView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: EditSchoolViewModel
    
    public init(viewModel: EditSchoolViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        viewModel.send(.closeButtonDidTap)
                    } label: {
                        Image(uiImage: .icClose)
                            .resizable()
                            .frame(width: 18, height: 18)
                            .tint(.Common.ButtonClose.default)
                    }
                }
                .padding(.bottom, 10.adjusted)
                
                HStack {
                    Text("Which school are you\n currently attending?")
                        .font(.bold_20)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.bottom, 39.adjusted)
                
                ForEach(viewModel.allUniversityItems, id: \.self) { university in
                    let isSelected = university == viewModel.university
                    HStack(spacing: 0) {
                        VStack {
                            if isSelected {
                                Image(uiImage: .icCheck)
                                    .resizable()
                                    .frame(width: 24.adjusted, height: 24.adjusted)
                                    .foregroundColor(.heyMain)
                            } else {
                                Image(uiImage: .icUnCheck)
                                    .resizable()
                                    .frame(width: 24.adjusted, height: 24.adjusted)
                                    .foregroundColor(Color.init(hex: "#747474"))
                            }
                        }
                        .padding(.leading, 24)
                        .padding(.vertical, 20.adjusted)
                        .padding(.trailing, 16)
                        
                        
                        Text(university.rawValue)
                            .font(.medium_16)
                            .foregroundColor(
                                isSelected
                                ? .common.MainText.default
                                : .common.Placeholder.default
                            )
                        Spacer()
                    }
                    .frame(height: 64.adjusted)
                    .padding(.horizontal, 8)
                    .background(
                        isSelected 
                        ? Color.common.Button.active2
                        : Color.common.Button.unactive
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(
                        isSelected
                        ? RoundedRectangle(cornerRadius: 8).stroke(
                            Color.heyMain, lineWidth: 2)
                        : nil
                    )
                    .onTapGesture {
                        viewModel.send(.selectUniversity(university))
                    }
                    .padding(.bottom, 16.adjusted)
                }
                
                Spacer()
                
                Button("Continue") {
                    viewModel.send(.continueButtonDidTap)
                }
                .disabled(!viewModel.state.continueButtonIsEnabled)
                .heyCTAButtonStyle()
            }
            
            .padding(.top, 92.adjusted)
            .padding(.bottom, 65.adjusted)
        }
        .padding(.horizontal, 16)
        .background(Color.common.Background.default)
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
    }
}

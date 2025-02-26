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
                    }
                }
                .padding(.bottom, 10)
                
                HStack {
                    Text("Which school are you\n currently attending?")
                        .font(.bold_20)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.bottom, 39)
                
                ForEach(viewModel.allUniversityItems, id: \.self) { university in
                    let isSelected = university == viewModel.university
                    HStack(spacing: 0) {
                        VStack {
                            if isSelected {
                                Image(uiImage: .icSelected)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                            } else {
                                Circle()
                                    .fill(.clear)
                                    .frame(width: 24, height: 24)
                                    .overlay(Circle().stroke(Color.init(hex: "B8B8B8"), lineWidth: 2))
                                
                            }
                        }
                        .padding(.leading, 24)
                        .padding(.vertical, 20)
                        .padding(.trailing, 16)
                        
                        
                        Text(university.rawValue)
                            .font(.medium_16)
                            .foregroundColor(isSelected ? .heyGray1 : .heyGray2)
                        Spacer()
                    }
                    .frame(height: 64)
                    .padding(.horizontal, 8)
                    .background(isSelected ? Color.init(hex: "EFF1FA") : Color.heyGray4)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .overlay(isSelected ? RoundedRectangle(cornerRadius: 8).stroke(Color.heyMain, lineWidth: 2) : nil)
                    .onTapGesture {
                        viewModel.send(.selectUniversity(university))
                    }
                    .padding(.bottom, 16)
                }
                
                
                
                Spacer()
                
                Button("Continue") {
                    viewModel.send(.continueButtonDidTap)
                }
                .disabled(!viewModel.state.continueButtonIsEnabled)
                .heyBottomButtonStyle()
            }
            
            .padding(.top, 92)
            .padding(.bottom, 65)
        }
        .padding(.horizontal, 16)
        .background(Color.heyWhite)
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
    }
}

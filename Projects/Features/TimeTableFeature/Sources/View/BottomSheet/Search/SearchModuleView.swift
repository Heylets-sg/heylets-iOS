//
//  ClassSearchView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain
import DSKit
import BaseFeatureDependency
import Core

public struct SearchModuleView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var reportMissingModuleAlertIsPresented: Bool
    @ObservedObject var viewModel: SearchModuleViewModel
    
    public var body: some View {
        VStack(spacing: 0) {
            ClassSearchBarView(viewModel: viewModel)
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
            
            ClassFilterView(viewModel: viewModel.filterViewModel, parentViewModel: viewModel)
                .padding(.top, 5)
                .padding(.bottom, 16)
                .padding(.horizontal, 16)
            
            if viewModel.lectureList.isEmpty && !viewModel.filterInfo.keyword.isEmpty {
                Text("We couldn't find a match for\n'\(viewModel.filterInfo.keyword)'.")
                    .font(.regular_16)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.common.Placeholder.default)
                    .padding(.bottom, 20)
                    .onAppear {
                        Analytics.shared.track(.screenView("missing_module", .modal))
                    }
                
                Button {
                    reportMissingModuleAlertIsPresented = true
                } label: {
                    HStack {
                        Text("Report Missing Modules")
                            .font(.regular_14)
                            .foregroundColor(.common.Placeholder.default)
                        
                        Image(uiImage: .icNext)
                            .resizable()
                            .frame(width: 4, height: 9)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.common.Placeholder.default, lineWidth: 1)
                    )
                }
                
                Spacer()
                
            } else {
                ScrollView {
                    ForEach(viewModel.lectureList, id: \.self) { lecture in
                        ClassSearchListCellView(
                            viewModel: viewModel,
                            isSelected: viewModel.state.selectedLecture == lecture,
                            section: lecture
                        ) {
                            viewModel.send(.lectureCellDidTap(lecture))
                        }
                        .padding(.bottom, 3)
                    }
                }
                .loading(viewModel.state.isLoading)
                .scrollIndicators(.hidden)
            }
        }
        .background(Color.common.Background.default)
        .ignoresSafeArea()
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
}

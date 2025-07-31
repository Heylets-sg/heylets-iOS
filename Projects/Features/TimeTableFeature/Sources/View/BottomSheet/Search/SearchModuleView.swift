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
                MissingModuleView(
                    keyword: viewModel.filterInfo.keyword,
                    reportMissingModuleAlertIsPresented: $reportMissingModuleAlertIsPresented
                )
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.lectureList.indices, id: \.self) { index in
                            ClassSearchListCellView(
                                isSelected: viewModel.state.selectedLecture == viewModel.lectureList[index],
                                section: viewModel.lectureList[index],
                                cellDidTap: { viewModel.send(.lectureCellDidTap(index)) },
                                addLectureDidTap: { viewModel.send(.addLectureButtonDidTap(index))}
                            )
                            .equatable()
                            .padding(.bottom, 3)
                            .onAppear {
                                if index == viewModel.lectureList.count-1 {
                                    viewModel.send(.loadMoreData)
//                                    print("마지막 셀입니다!!!!")
                                }
                            }
                        }
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

fileprivate struct MissingModuleView: View {
    var keyword: String
    @Binding var reportMissingModuleAlertIsPresented: Bool
    
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
            reportMissingModuleAlertIsPresented = true
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

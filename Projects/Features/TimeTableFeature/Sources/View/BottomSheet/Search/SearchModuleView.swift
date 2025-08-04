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
    @ObservedObject var viewModel: SearchModuleViewModel
    var onReport: () -> Void
    
    public var body: some View {
        VStack(spacing: 0) {
            ClassSearchBarView(viewModel: viewModel)
                .padding(.vertical, 16)
                .padding(.horizontal, 16)
            
            ClassFilterView(
                viewModel: viewModel.filterViewModel,
                filterInfo: $viewModel.filterInfo
            )
            .padding(.top, 5)
            .padding(.bottom, 16)
            .padding(.horizontal, 16)
            
            if viewModel.lectureList.isEmpty && !viewModel.filterInfo.keyword.isEmpty {
                MissingModuleView(
                    keyword: viewModel.filterInfo.keyword,
                    onReport: { onReport() }
                )
            } else {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack {
                            ForEach(viewModel.lectureList.indices, id: \.self) { index in
                                ClassSearchListCellView(
                                    isSelected: viewModel.state.selectedLecture == viewModel.lectureList[index],
                                    section: viewModel.lectureList[index],
                                    cellDidTap: {
                                        viewModel.send(.lectureCellDidTap(index))
                                    },
                                    addLectureDidTap: { viewModel.send(.addLectureButtonDidTap(index))}
                                )
                                .equatable()
                                .padding(.bottom, 3)
                                .onAppear {
                                    if index == viewModel.lectureList.count-1 {
                                        viewModel.send(.loadMoreData)
                                    }
                                }
                            }
                        }
                        .onChange(of: viewModel.state.isScrollToTop) {
                            if $0 {
                                proxy.scrollTo(0)
                                viewModel.state.isScrollToTop = false
                            }
                        }
                    }
                    .loading(viewModel.state.isLoading)
                    .scrollIndicators(.hidden)
                }
            }
        }
        .background(Color.common.Background.default)
        .ignoresSafeArea()
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
}

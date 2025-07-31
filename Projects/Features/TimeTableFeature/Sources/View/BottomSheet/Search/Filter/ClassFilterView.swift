//
//  ClassFilterView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain

struct ClassFilterView: View {
    @ObservedObject var viewModel: SearchFilterViewModel
    @Binding var filterInfo: FilterInfo
    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            
            VStack(alignment: .leading) {
                HStack(spacing: 8) {
                    ForEach(ClassFilterType.allCases, id: \.self) { type in
                        ClassFilterCapsuleView(
                            title: type.title,
                            isSelected: isFilterSelected(type),
                            screenWidth: screenWidth,
                            action: {
                                viewModel.send(.filterButtonDidTap(type))
                            }
                        )
                    }
                }
            }
        }
        .frame(height: 40)
        .sheet(isPresented: $viewModel.state.isPresented) {
            ClassFilterBottomSheetView(
                filterType: viewModel.filterType,
                filterList: $viewModel.filterList,
                backButtonAction: { viewModel.send(.backButtonDidTap) },
                applyButtonAction: { viewModel.send(.applyButtonDidTap) }
            )
            .presentationDetents([.height(417)])
            .presentationDragIndicator(.visible)
            .ignoresSafeArea(.container, edges: .bottom)
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
    
    // 기기 크기에 따른 스페이싱 조정
    private func adaptiveSpacing(for width: CGFloat) -> CGFloat {
        if width < 320 { return 5 }      // iPhone SE (1세대)
        else if width < 375 { return 6 } // iPhone SE (2/3세대), iPhone 8
        else if width < 428 { return 8 } // iPhone 11/12/13 등
        else { return 10 }               // 더 큰 기기
    }
    
    private func isFilterSelected(_ type: ClassFilterType) -> Bool {
        switch type {
        case .department: return filterInfo.department != nil
        case .semester: return filterInfo.semester != nil
        case .level: return filterInfo.level != nil
        case .other: return filterInfo.keywordType != nil
        }
    }
}

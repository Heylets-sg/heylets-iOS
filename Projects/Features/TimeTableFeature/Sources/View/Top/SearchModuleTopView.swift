//
//  SearchModuleTopView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct SearchModuleTopView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var isShowingAddCustomModuleView: Bool
    @ObservedObject var viewModel: SearchModuleViewModel
    @ObservedObject var addCustomViewModel: AddCustomModuleViewModel
    
    public var body: some View {
        HStack {
            Button {
                withAnimation {
                    viewType = .main
                }
            } label: {
                Image(uiImage: .icClose)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
            
            Spacer()
            
            Button {
                withAnimation {
                    viewType = .addCustom
                    isShowingAddCustomModuleView = true
                }
            } label: {
                Image(uiImage: .icPencil)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 28)
            }
            
            Button {
                withAnimation {
                    viewModel.send(.addLectureButtonDidTap)
                }
            } label: {
                Image(uiImage: .icPlus)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
        }
        .padding(.horizontal, 16)
//        .sheet(isPresented: $viewModel.state.isShowingAddCustomModuleView) {
//            AddCustomModuleView(viewModel: addCustomViewModel)
//                .presentationDetents([.medium, .large, .height(506)])
//                .presentationDragIndicator(.hidden)
//        }
    }
}

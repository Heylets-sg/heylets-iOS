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
    @State private var isShowingAddModuleView = false
    
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
                    isShowingAddModuleView.toggle()
                }
            } label: {
                Image(uiImage: .icPencil)
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(.trailing, 28)
            }
            
            Button {
                withAnimation {
                    //TODO: 모듈 추가 비즈니스 로직 추가
                    viewType = .main
                }
            } label: {
                Image(uiImage: .icPlus)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $isShowingAddModuleView) {
            AddModuleView()
                .presentationDetents([.medium, .large, .height(506)])
                .presentationDragIndicator(.hidden)
        }
    }
}

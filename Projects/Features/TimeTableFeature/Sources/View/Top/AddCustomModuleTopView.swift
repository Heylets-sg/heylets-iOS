//
//  AddCustomModuleTopView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/7/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct AddCustomModuleTopView: View {
    @Binding var viewType: TimeTableViewType
    @ObservedObject var viewModel: AddCustomModuleViewModel
    
    var body: some View {
        VStack {
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
                    viewModel.send(.saveCustomModuleButtonDidTap)
                } label: {
                    Text("Save")
                        .font(.medium_16)
                        .foregroundColor(
                            viewModel.schedule.isEmpty
                            ? .common.Button.Save.unactive
                            : .common.Button.Save.active
                        )
                }
                .disabled(viewModel.schedule.isEmpty)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 26)
        }
        .onChange(of: viewModel.state.isAddSuccess) {
            if $0 { withAnimation { viewType = .main } }
        }
    }
}

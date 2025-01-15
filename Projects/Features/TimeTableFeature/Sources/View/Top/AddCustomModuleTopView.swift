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
                    viewType = .main //TODO: 커스텀 모듈 추가 성공하면 해당 로직 실행
                    viewModel.send(.addCustomModuleButtonDidTap)
                } label: {
                    Text("Save")
                        .font(.medium_16)
                        .foregroundColor(.heyGray1)
                    
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 26)
        }
        .onChange(of: viewModel.state.isAddSuccess) {
            if $0 { withAnimation { viewType = .main }
            }
        }
    }
}

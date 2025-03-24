//
//  ClassFilterView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct ClassFilterView: View {
    @ObservedObject var viewModel: SearchFilterViewModel
    
    var body: some View {
        HStack {
            Text("name/code:")
                .font(.regular_12)
                .foregroundColor(.heyGray2)
            
            TextField(text: $viewModel.searchText, label: {
                
            })
            .font(.medium_12)
            .foregroundColor(.heySubMain2)
            .onSubmit {
                viewModel.send(.searchButtonDidTap)
            }
            
            Spacer()
            
            Button {
                viewModel.send(.clearButtonDidTap)
            } label: {
                Image(uiImage: .icClose.withRenderingMode(.alwaysTemplate))
                    .resizable()
                    .tint(.heyGray2)
                    .frame(width: 6, height: 6)
                    .padding(.all, 6)
                    .background(Color.heyGray9)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 9)
        .background(Color.heyGray10)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

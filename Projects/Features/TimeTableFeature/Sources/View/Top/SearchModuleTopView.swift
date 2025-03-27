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
    var addCustomModuleButtonDidTapEvent: (() -> Void)
    var closeButtonDidTapEvent: (() -> Void)
    
    
    public var body: some View {
        HStack {
            Button {
                withAnimation {
                    closeButtonDidTapEvent()
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
                    addCustomModuleButtonDidTapEvent()
                }
            } label: {
                Image(uiImage: .icPencil)
                    .resizable()
                    .frame(width: 16, height: 16)
            }
        }
        .padding(.horizontal, 16)
    }
}

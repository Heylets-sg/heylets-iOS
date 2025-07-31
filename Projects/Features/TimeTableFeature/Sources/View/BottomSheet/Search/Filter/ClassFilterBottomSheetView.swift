//
//  ClassFilterBottomSheetView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct ClassFilterBottomSheetView: View {
    var filterType: ClassFilterType
    @Binding var filterList: [FilterItemType]
    let backButtonAction: () -> Void
    let applyButtonAction: () -> Void
    
    private var selectedCount: Int {
        filterList.filter { $0.isSelected }.count
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(filterType.title)
                    .font(.bold_20)
                    .foregroundColor(.common.MainText.default)
                
                Spacer()
            }
            .padding(.bottom, 16)
            .padding(.horizontal, 24)
            
            Rectangle()
                .fill(Color.common.Divider.default)
                .frame(height: 1)
                .padding(.horizontal, 16)
            
            ScrollView {
                ForEach(0..<filterList.count, id: \.self) { index in
                    ClassFilterCellView(
                        isSelected: Binding(
                            get: { filterList[index].isSelected },
                            set: { newValue in
                                if newValue {
                                    for i in 0..<filterList.count {
                                        filterList[i].isSelected = (i == index)
                                    }
                                } else {
                                    filterList[index].isSelected = false
                                }
                            }
                        ),
                        name: filterList[index].title
                    )
                    .padding(.bottom, 24)
                }
            }
            .padding(.horizontal, 16)
            
            Spacer()
            
            GeometryReader { proxy in
                HStack(spacing: 17) {
                    Button {
                        backButtonAction()
                    } label: {
                        Text("Back")
                            .font(.semibold_16)
                            .foregroundColor(.init(hex: "#8D8D91"))
                            .padding(.vertical, 15)
                    }
                    .frame(width: proxy.size.width * 0.29)
                    .background(Color.init(hex: "#F4F4F4"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    Button {
                        applyButtonAction()
                    } label: {
                        Text("Apply")
                            .font(.semibold_16)
                            .foregroundColor(.common.CTAText.active)
                            .padding(.vertical, 15)
                    }
                    .frame(width: proxy.size.width * 0.58)
                    .background(Color.common.CTA.active)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal, proxy.size.width * 0.04)
            }
            .frame(height: 52)
            .padding(.bottom, 40)
            
        }
        .padding(.top, 44)
    }
}

struct ClassFilterCellView: View {
    @Binding var isSelected: Bool
    var name: String
    
    var body: some View {
        HStack {
            (isSelected ? Image.icCompleted : Image.icBlank)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.trailing, 8)
            
            Text(name)
                .font(.medium_14)
                .padding(.vertical, 2)
            
            Spacer()
        }
//        .background(Color.timeTableSub.Filter.list)
        .onTapGesture { isSelected.toggle() }
    }
}

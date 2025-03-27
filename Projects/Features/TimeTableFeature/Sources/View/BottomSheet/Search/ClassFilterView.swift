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
    @ObservedObject var parentViewModel: SearchModuleViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(ClassFilterType.allCases, id: \.self) { type in
                        ClassFilterCapsuleView(
                            title: type.title,
                            isSelected: isFilterSelected(type),
                            action: {
                                viewModel.send(.filterButtonDidTap(type))
                            }
                        )
                    }
                }
            }
        }
        .sheet(isPresented: $viewModel.state.isPresented) {
            ClassFilterBottomSheetView(
                filterType: viewModel.filterType,
                filterList: $viewModel.filterList,
                backButtonAction: { viewModel.send(.backButtonDidTap) },
                applyButtonAction: { viewModel.send(.applyButtonDidTap) }
            )
            .presentationDetents([.height(400)])
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
    
    private func isFilterSelected(_ type: ClassFilterType) -> Bool {
        switch type {
        case .department:
            return parentViewModel.filterInfo.department != nil
        case .semester:
            return parentViewModel.filterInfo.semester != nil
        case .level:
            return parentViewModel.filterInfo.level != nil
        case .other:
            return parentViewModel.filterInfo.other != nil
        }
    }
}

struct ClassFilterCapsuleView: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.semibold_12)
                    .foregroundColor(isSelected ? .heyMain : .heyGray1)

                Image(uiImage: .icDown)
                    .resizable()
                    .frame(width: 9, height: 4)
                    .foregroundColor(isSelected ? .heyMain : .heyGray1)
                
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 11)
            .frame(height: 36)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(
                        isSelected
                        ? Color.heyMain.opacity(0.1)
                        : Color.white
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                isSelected
                                ? Color.heyMain
                                : Color.init(hex: "#E3E3E3"),
                                lineWidth: 1.8
                            )
                    )
            )
        }
    }
}

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
                
                Spacer()
            }
            .padding(.bottom, 16)
            .padding(.horizontal, 24)
            
            Rectangle()
                .fill(Color.init(hex: "#E3E3E3"))
                .frame(height: 1)
            
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
            .padding(.horizontal, 24)
            
            HStack(spacing: 17) {
                Button {
                    backButtonAction()
                } label: {
                    Text("Back")
                        .font(.semibold_16)
                        .foregroundColor(.init(hex: "#8D8D91"))
                        .padding(.horizontal, 38)
                        .padding(.vertical, 15)
                        .background(Color.init(hex: "#F4F4F4"))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                Button {
                    applyButtonAction()
                } label: {
                    Text("Apply")
                        .font(.semibold_16)
                        .foregroundColor(.heyWhite)
                        .padding(.horizontal, 90)
                        .padding(.vertical, 15)
                        .background(Color.heyMain)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            .padding(.horizontal, 16)
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
            Image(uiImage: isSelected ? .icCompleted : .icBlank)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.trailing, 12)
            
            Text(name)
                .font(.medium_14)
                .padding(.vertical, 2)
            
            Spacer()
        }
        .onTapGesture { isSelected.toggle() }
    }
}

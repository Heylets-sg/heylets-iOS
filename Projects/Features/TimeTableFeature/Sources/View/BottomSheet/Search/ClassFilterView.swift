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
        case .department:
            return parentViewModel.filterInfo.department != nil
        case .semester:
            return parentViewModel.filterInfo.semester != nil
        case .level:
            return parentViewModel.filterInfo.level != nil
        case .other:
            return parentViewModel.filterInfo.keywordType != nil
        }
    }
}

struct ClassFilterCapsuleView: View {
    let title: String
    let isSelected: Bool
    let screenWidth: CGFloat
    let action: () -> Void
    
    // 기기 크기에 따른 적응형 패딩 계산
    private var horizontalPadding: CGFloat {
        if screenWidth <= 390 { return 12 }      // 매우 작은 화면
        else { return 19 }                     // 큰 화면
    }
    
    // 기기 크기에 따른 최소 너비 계산
    private var minWidth: CGFloat {
        let baseWidth: CGFloat = CGFloat(title.count * 8 + 20) // 글자당 대략 8포인트, 아이콘과 여유 공간 20포인트
        
        if screenWidth < 320 {
            return min(baseWidth, 70)     // 작은 화면에서는 최대 70포인트
        } else if screenWidth < 375 {
            return min(baseWidth, 80)     // 중간 화면에서는 최대 80포인트
        } else if screenWidth < 428 {
            return min(baseWidth, 90)     // 큰 화면에서는 최대 90포인트
        } else {
            return min(baseWidth, 100)    // 아주 큰 화면에서는 최대 100포인트
        }
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(title)
                    .font(.semibold_12)
                    .foregroundColor(
                        isSelected 
                        ? .Filter.Text.active
                        : .Filter.Text.unActive
                    )
                
                Image.icDown
                    .resizable()
                    .frame(width: 9, height: 4)
                    .foregroundColor(
                        isSelected
                        ? .Filter.Text.active
                        : .Filter.Text.unActive
                    )
            }
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, 11)
            .background(
                Capsule()
                    .fill(
                        isSelected
                        ? Color.heyMain.opacity(0.1)
                        : Color.clear
                    )
                    .overlay(
                        Capsule()
                            .stroke(
                                isSelected
                                ? Color.Filter.Stroke.active
                                : Color.Filter.Stroke.unActive,
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

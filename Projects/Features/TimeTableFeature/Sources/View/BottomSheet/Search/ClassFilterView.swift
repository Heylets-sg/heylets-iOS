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
    @State var isPresented: Bool = false
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(ClassFilterType.allCases, id: \.self) { type in
                ClassFilterCapsuleView(
                    title: type.title,
                    isSelected: false,
                    action: { isPresented = true }
                )
            }
        }
        .sheet(isPresented: $isPresented) {
            ClassFilterBottomSheetView()
                .presentationDetents([.height(417)])
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
                        ? Color.heyMain
                        : Color.white
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(
                                isSelected
                                ? Color.init(hex: "#6E7AB3")
                                : Color.init(hex: "#E3E3E3"),
                                lineWidth: 1.8
                            )
                    )
            )
        }
    }
}

struct ClassFilterBottomSheetView: View {
    var arr: [String] = Array(repeating: "temp", count: 20)
    var body: some View {
        VStack(alignment: .leading) {
            Text("DepartMent")
                .font(.bold_20)
                .padding(.bottom, 16)
                .padding(.horizontal, 24)
            
            Rectangle()
                .fill(Color.init(hex: "#E3E3E3"))
                .frame(height: 1)
            
            ScrollView {
                ForEach(arr, id: \.self) { _ in
                    ClassFilterCellView(isSelected: true, name: "temptemp")
                        .padding(.bottom, 24)
                }
            }
            .padding(.horizontal, 24)
            
            HStack(spacing: 17) {
                Button {
                    
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
                    
                } label: {
                    Text("Apply")
                        .font(.semibold_16)
                        .foregroundColor(.heyWhite)
                        .padding(.horizontal, 80)
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
    var isSelected: Bool
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
    }
}

//
//  ClassSearchListCellView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI
import Combine

import DSKit
import Domain

struct ClassSearchListCellView: View {
    @ObservedObject var viewModel: SearchModuleViewModel
    var isSelected: Bool
    var section: SectionInfo
    var cellDidTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextWithCustomFontSubstring(
                originalText: "\(section.code!) \(section.name)",
                targetSubstring: section.code!,
                targetFont: .bold_14
            )
            .font(.medium_14)
            .foregroundColor(.heyGray1)
            .lineLimit(2)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 12)
            .padding(.bottom, 6)
            .padding(.trailing, 103)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(section.allscheduleTime)
                .font(.regular_12)
                .foregroundColor(isSelected ? Color.heyGray2 : Color.heyGray8)
            
            Text("\(section.professor) / \(section.location) \(section.unit.map { " / \($0) unit" } ?? "")")
                .font(.regular_12)
                .foregroundColor(isSelected ? Color.heyGray2 : Color.heyGray8)
                .padding(.bottom, 15)
            
            if isSelected {
                HStack {
                    Button {
                        viewModel.send(.addLectureButtonDidTap(section))
                    } label: {
                        Text("Add")
                            .font(.regular_12)
                            .foregroundColor(Color.heyWhite)
                            .padding(.vertical, 5)
                            .frame(width: 46, height: 25)
                            .background(Color.heyMain)
                            .clipShape(RoundedRectangle(cornerRadius: 12.5))
                            .padding(.trailing, 7)
                    }
                }
                .padding(.bottom, 10)
            } else {
                EmptyView()
            }
        }
        .padding(.horizontal, 16)
        .background(isSelected ? Color.heySubMain3 : Color.black.opacity(0.0001))
        .onTapGesture {
            cellDidTap()
        }
    }
}

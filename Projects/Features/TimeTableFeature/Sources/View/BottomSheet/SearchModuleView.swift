//
//  ClassSearchView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain
import DSKit


public struct SearchModuleView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var reportMissingModuleAlertIsPresented: Bool
    @ObservedObject var viewModel: SearchModuleViewModel
    
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 27)
            
            ClassSearchBarView(viewModel: viewModel)
                .padding(.bottom, 28)
                .padding(.horizontal, 16)
            
            if viewModel.state.filteredItems.isEmpty {
                Text("We couldn’t find a match for\n‘Career and Enterpreneurial’.")
                    .font(.regular_16)
                    .foregroundColor(.heyGray2)
                    .padding(.bottom, 20)
                
                Button {
                    reportMissingModuleAlertIsPresented = true
                } label: {
                    HStack {
                        Text("Report Missing Modules")
                            .font(.regular_14)
                            .foregroundColor(.heyGray2)
                        
                        Image(uiImage: .icNext)
                            .resizable()
                            .frame(width: 4, height: 9)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 7)
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.heyGray3, lineWidth: 1)
                    )
                }
                
                Spacer()
                
            } else {
                ScrollView {
                    ForEach(viewModel.state.filteredItems, id: \.self) { lecture in
                        ClassSearchListCellView(
                            isSelected: viewModel.state.selectedLecture == lecture,
                            lecture: lecture
                        ) {
                            viewModel.send(.lectureCellDidTap(lecture))
                        }
                        .padding(.bottom, 16)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .cornerRadius(12, corners: [.topLeft, .topRight])
        
    }
}

fileprivate struct ClassSearchBarView: View {
    @ObservedObject var viewModel: SearchModuleViewModel
    
    var body: some View {
        HStack {
            Text("name/code:")
                .font(.regular_12)
                .foregroundColor(.heyGray2)
            
            TextField(text: $viewModel.searchText, label: {
                
            })
            .font(.medium_12)
            .foregroundColor(.heyMain)
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
                    .background(Color.heyGray3)
                    .clipShape(Circle())
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 9)
        .background(Color.heyGray6)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

fileprivate struct ClassSearchListCellView: View {
    var isSelected: Bool
    var lecture: LectureInfo
    var cellDidTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(lecture.code) \(lecture.name)")
                .font(.medium_14)
                .foregroundColor(.heyGray1)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 6)
                .padding(.trailing, 87)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(lecture.allscheduleTime)
                .font(.regular_12)
                .foregroundColor(.heyGray3)
                .padding(.bottom, 2)
            
            Text("\(lecture.professor ?? "TO BE ") / \(lecture.location) / \(lecture.unit!) unit")
                .font(.regular_12)
                .foregroundColor(.heyGray3)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(isSelected ? Color.heyMain : Color.clear)
        .onTapGesture {
            cellDidTap()
        }
    }
}
//#Preview {
//    SearchModuleView()
//}

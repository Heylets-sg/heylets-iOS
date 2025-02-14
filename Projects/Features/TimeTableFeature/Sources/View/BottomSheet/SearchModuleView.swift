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
import BaseFeatureDependency


public struct SearchModuleView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var reportMissingModuleAlertIsPresented: Bool
    @ObservedObject var viewModel: SearchModuleViewModel
    
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 27)
            
            ClassSearchBarView(viewModel: viewModel)
                .padding(.bottom, 18)
                .padding(.horizontal, 16)
            
            if viewModel.lectureList.isEmpty {
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
                    ForEach(viewModel.lectureList, id: \.self) { lecture in
                        ClassSearchListCellView(
                            viewModel: viewModel,
                            isSelected: viewModel.state.selectedLecture == lecture,
                            section: lecture
                        ) {
                            viewModel.send(.lectureCellDidTap(lecture))
                        }
                        .padding(.bottom, 3)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .frame(height: 450)
        .shadow(color: .init(hex: "#B5B5B5").opacity(0.13), radius: 16, y: -4)
        .onAppear {
            viewModel.send(.onAppear)
        }
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

fileprivate struct ClassSearchListCellView: View {
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
            
            Text("\(section.professor) / \(section.location) / \(section.unit) unit")
                .font(.regular_12)
                .foregroundColor(isSelected ? Color.heyGray2 : Color.heyGray8)
                .padding(.bottom, 15)
            
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
        }
        .padding(.horizontal, 16)
        .background(isSelected ? Color.heySubMain3 : Color.clear)
        .onTapGesture {
            cellDidTap()
        }
    }
}

#Preview {
    @State var stub: TimeTableViewType = .search
    let useCase = StubHeyUseCase.stub.timeTableUseCase
    return TimeTableView(
        viewModel: .init(useCase),
        searchModuleViewModel: .init(useCase),
        addCustomModuleViewModel: .init(useCase),
        themeViewModel: .init(useCase)
    )
    .environmentObject(Router.default)
}

//
//  ClassSearchView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit

public struct SearchModuleView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var reportMissingModuleAlertIsPresented: Bool
    @Binding var inValidregisterModuleIsPresented: Bool
    
    var classList: [String] = ["","","","","","","","","",""]
    public var body: some View {
        VStack {
            Spacer()
                .frame(height: 27)
            
            ClassSearchBarView()
                .padding(.bottom, 28)
            
            if classList.isEmpty {
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
                    ForEach(classList, id: \.self) { _ in
                        ClassSearchListCellView(inValidregisterModuleIsPresented: $inValidregisterModuleIsPresented, viewType: $viewType)
                            .padding(.bottom, 24)
                    }
                }
                .scrollIndicators(.hidden)
            }
            
            
        }
        .padding(.horizontal, 16)
        .cornerRadius(12, corners: [.topLeft, .topRight])
        
    }
}

fileprivate struct ClassSearchBarView: View {
    @State var text = ""
    var body: some View {
        HStack {
            Text("name/code:")
                .font(.regular_12)
                .foregroundColor(.heyGray2)
            
            TextField(text: $text, label: {
                
            })
            .font(.medium_12)
            .foregroundColor(.heyMain)
            
            Spacer()
            
            Button {
                
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
    @State var text = ""
    @Binding var inValidregisterModuleIsPresented: Bool
    @Binding var viewType: TimeTableViewType
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("ML0004 Career and Entrepreneurial Development")
                .font(.medium_14)
                .foregroundColor(.heyGray1)
                .padding(.bottom, 6)
            
            Text("Mon 12:00 - 13:00, Thu 9:00 - 10:00")
                .font(.regular_12)
                .foregroundColor(.heyGray3)
                .padding(.bottom, 2)
            
            Text("TBA / SOE CR B1-2(T), SOE CR B1-2(M) / 2 unit")
                .font(.regular_12)
                .foregroundColor(.heyGray3)
        }
        .padding(.trailing, 87)
        .onTapGesture {
            viewType = .main
            inValidregisterModuleIsPresented = true
        }
    }
}
//#Preview {
//    SearchModuleView()
//}

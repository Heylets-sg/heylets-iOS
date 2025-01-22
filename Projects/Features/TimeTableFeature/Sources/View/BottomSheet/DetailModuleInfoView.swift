//
//  ClassDetailInfoView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import Domain

public struct DetailModuleInfoView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var deleteModuleAlertIsPresented: Bool
    private var sectionInfo: SectionInfo = .empty
    
    init(
        viewType: Binding<TimeTableViewType>,
        deleteModuleAlertIsPresented: Binding<Bool>,
        sectionInfo: SectionInfo
    ) {
        self._viewType = viewType
        self._deleteModuleAlertIsPresented = deleteModuleAlertIsPresented
        self.sectionInfo = sectionInfo
    }
    
    public var body: some View {
        
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text(sectionInfo.code ?? "")
                    .font(.semibold_14)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.heySubMain)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                
                Text(sectionInfo.name)
                    .font(.semibold_18)
                    .foregroundColor(.heyGray1)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.trailing, 120)
            .padding(.leading, 25)
            
            Spacer()
                .frame(height: 16)
            
            VStack(alignment: .leading, spacing: 7) {
                Text(sectionInfo.allscheduleTime)
                    .font(.regular_14)
                    .foregroundColor(.heyGray2)
                
                Text(sectionInfo.professor)
                    .font(.regular_14)
                    .foregroundColor(.heyGray2)
                
                Text("\(sectionInfo.location) / \(sectionInfo.unit ?? 0) unit")
                    .font(.regular_14)
                    .foregroundColor(.heyGray2)
                
            }
            .padding(.leading, 25)
            .padding(.bottom, 47)
            
            HStack {
                Spacer()
                
                Button {
                    viewType = .main
                    deleteModuleAlertIsPresented.toggle()
                } label: {
                    VStack {
                        Text("Delete")
                            .font(.regular_14)
                            .foregroundColor(.heyGray2)
                        
                        Divider()
                            .frame(width: 43)
                            .foregroundColor(.heyGray2)
                    }
                }
                Spacer()
            }
            
            Spacer()
                .frame(height: 36)
        }
        .padding(.top, 25)
        .frame(height: 280)
        .cornerRadius(12, corners: [.topLeft, .topRight])
    }
}

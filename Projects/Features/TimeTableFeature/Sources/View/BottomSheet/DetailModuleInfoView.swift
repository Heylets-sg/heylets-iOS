//
//  ClassDetailInfoView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import Domain
import BaseFeatureDependency

public struct DetailModuleInfoView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var deleteModuleAlertIsPresented: Bool
    private var sectionInfo: SectionInfo = .timetable_stub1
    
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
                Text(SectionInfo.timetable_stub1.code ?? "")
                    .font(.semibold_14)
                    .foregroundColor(Color.init(hex: SectionInfo.timetable_stub1.textColor))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.init(hex: SectionInfo.timetable_stub1.backgroundColor))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                
                
                Text(SectionInfo.timetable_stub1.name)
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
                Text(SectionInfo.timetable_stub1.allscheduleTime)
                    .font(.regular_14)
                    .foregroundColor(.heyGray2)
                
                Text(SectionInfo.timetable_stub1.professor)
                    .font(.regular_14)
                    .foregroundColor(.heyGray2)
                
                Text("\(SectionInfo.timetable_stub1.location) / \(SectionInfo.timetable_stub1.unit) unit")
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

#Preview {
    @State var stub: TimeTableViewType = .detail
    let useCase = StubHeyUseCase.stub.timeTableUseCase
    return TimeTableView(
        viewModel: .init(useCase),
        searchModuleViewModel: .init(useCase),
        addCustomModuleViewModel: .init(useCase),
        themeViewModel: .init(useCase)
    )
    .environmentObject(Router.default)
}

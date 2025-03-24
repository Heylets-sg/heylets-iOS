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
                Text(sectionInfo.code ?? "custom")
                    .font(.semibold_14)
                    .foregroundColor(Color.init(hex: sectionInfo.textColor))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.init(hex: sectionInfo.backgroundColor))
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .padding(.top, 24)
                    .padding(.trailing, 120)
                
                Text(sectionInfo.name)
                    .font(.semibold_18)
                    .foregroundColor(.heyGray1)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
//                    .frame(maxWidth: .infinity, maxHeight: 40, alignment: .leading)
                    .padding(.top, 12)
                    .padding(.bottom, 16)
                    .padding(.trailing, 120)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(sectionInfo.allscheduleTime)
                        .font(.regular_14)
                        .foregroundColor(.heyGray2)
                        .padding(.trailing, 24)
                    
                    Text(sectionInfo.professor)
                        .font(.regular_14)
                        .foregroundColor(.heyGray2)
                    
                    Text("\(sectionInfo.location)\(sectionInfo.unit.map { " / \($0) unit" } ?? "")")
                        .font(.regular_14)
                        .foregroundColor(.heyGray2)
                }
            }
            .padding(.leading, 24)
            .padding(.bottom, 44)
            
            HStack {
                Spacer()
                
                Button {
                    viewType = .main
                    deleteModuleAlertIsPresented.toggle()
                } label: {
                    Text("Delete")
                        .font(.regular_14)
                        .foregroundColor(.heyGray2)
                }
                Spacer()
            }
        }
        .background(Color.heyWhite)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onDisappear {
            if viewType == .detail {
                viewType = .main
            }
        }
    }
}


//#Preview {
//    @State var stub: TimeTableViewType = .detail
//    let useCase = StubHeyUseCase.stub.timeTableUseCase
//    return TimeTableView(
//        viewModel: .init(
//            Router.default.navigationRouter,
//            Router.default.windowRouter,
//            useCase),
//        searchModuleViewModel: .init(useCase),
//        addCustomModuleViewModel: .init(useCase),
//        themeViewModel: .init(useCase)
//    )
//    .environmentObject(Router.default)
//}

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
    @EnvironmentObject var coordinator: TimeTableCoordinator
    
    private var sectionInfo: SectionInfo = .empty
    var onDelete: () -> Void
    
    init(
        sectionInfo: SectionInfo,
        onDelete: @escaping () -> Void
    ) {
        self.sectionInfo = sectionInfo
        self.onDelete = onDelete
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
                    .foregroundColor(.common.MainText.default)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 12)
                    .padding(.bottom, 16)
                    .padding(.trailing, 120)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(sectionInfo.allscheduleTime)
                        .font(.regular_14)
                        .foregroundColor(.timeTableMain.ModuleInfo.info)
                        .padding(.trailing, 24)
                    
                    Text(sectionInfo.professor)
                        .font(.regular_14)
                        .foregroundColor(.timeTableMain.ModuleInfo.info)
                    
                    Text("\(sectionInfo.location)\(sectionInfo.unit.map { " / \($0) unit" } ?? "")")
                        .font(.regular_14)
                        .foregroundColor(.timeTableMain.ModuleInfo.info)
                }
            }
            .padding(.leading, 24)
            .padding(.bottom, 44)
            
            HStack {
                Spacer()
                
                Button {
                    coordinator.presentCoordinator.reset()
                    onDelete()
                } label: {
                    Text("Delete")
                        .font(.regular_14)
                        .foregroundColor(.timeTableMain.ModuleInfo.delete)
                }
                Spacer()
            }
        }
        .background(Color.timeTableMain.bottomSheet)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .onDisappear {
            if coordinator.presentCoordinator.viewType == .detail {
                coordinator.presentCoordinator.reset()
            }
        }
    }
}

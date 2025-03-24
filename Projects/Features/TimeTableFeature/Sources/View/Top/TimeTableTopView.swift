//
//  TimeTableTopView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain
import DSKit
import BaseFeatureDependency

public struct TopView: View {
    @EnvironmentObject var container: Router
    @Binding var timeTableInfo: TimeTableInfo
    @Binding var viewType: TimeTableViewType
    @Binding var settingAlertType: TimeTableSettingAlertType?
    @Binding var profileInfo: ProfileInfo
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 34)
                
                HStack {
                    Image(uiImage: profileInfo.university.badgeImage)
                        .resizable()
                        .frame(width: 28, height: 14)
                        
                    
                    Text(timeTableInfo.fullSemester)
                        .font(.medium_12)
                        .foregroundColor(.heyGray2)
                }
                .padding(.bottom, 8)
                
                Text(timeTableInfo.timeTableName)
                    .lineLimit(1)
                    .font(.semibold_18)
                    .foregroundColor(.heyGray1)
            }
            
            Spacer()
            
            HStack {
                Button {
                    withAnimation {
                        viewType = .search
                    }
                } label: {
                    Image(uiImage: .icAdd.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .frame(width: 16, height: 16)
                        .tint(.heyGray2)
                        .padding(.trailing, 26)
                }
                
                Button {
                    withAnimation {
                        viewType = .setting
                    }
                } label: {
                    Image(uiImage: .icSetting.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(.heyGray2)
                        .padding(.trailing, 23)
                }
            }
            .padding(.top, 38)
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: .constant(viewType == .setting)) {
            SettingTimeTableView(
                viewType: $viewType,
                settingAlertType: $settingAlertType
            )
            .presentationDetents([.fraction(0.37)])
            .presentationDragIndicator(.hidden)
            .ignoresSafeArea(.container, edges: .bottom)
        }
    }
}

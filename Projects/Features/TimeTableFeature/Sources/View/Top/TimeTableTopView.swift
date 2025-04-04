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
    @Binding var profileInfo: ProfileInfo
    
    public var body: some View {
        
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(uiImage: profileInfo.university.badgeImage)
                        .resizable()
                        .frame(width: 36, height: 18)
                    
                    
                    Text(timeTableInfo.fullSemester)
                        .font(.medium_12)
                        .foregroundColor(.heyGray2)
                }
                .padding(.bottom, 10.adjusted)
                
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
                        .frame(width: 17, height: 17)
                        .tint(.init(hex: "#353536"))
                        .padding(.trailing, 26)
                }
                
                Button {
                    withAnimation {
                        viewType = .setting
                    }
                } label: {
                    Image(uiImage: .icSetting.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .frame(width: 18, height: 18)
                        .tint(.init(hex: "#353536"))
                }
            }
            .padding(.trailing, 8)
        }
        .padding(.horizontal, 16)
    }
}


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
        GeometryReader { proxy in
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Image(uiImage: profileInfo.university.badgeImage)
                            .resizable()
                            .frame(width: proxy.size.height * 0.68, height: proxy.size.height * 0.34)
                            
                        
                        Text(timeTableInfo.fullSemester)
                            .font(.medium_12)
                            .foregroundColor(.heyGray2)
                    }
                    .padding(.bottom, proxy.size.height * 0.2)
                    
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
                            .frame(width: proxy.size.height * 0.32, height: proxy.size.height * 0.32)
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
                            .frame(width: proxy.size.height * 0.34, height: proxy.size.height * 0.34)
                            .tint(.init(hex: "#353536"))
                    }
                }
                .padding(.trailing, 24)
                .padding(.vertical, proxy.size.height * 0.33)
//                .frame(height: 18)
            }
            .padding(.horizontal, 16)
        }
    }
}

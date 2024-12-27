//
//  TimeTableTopView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit
import BaseFeatureDependency

public struct TopView: View {
    @EnvironmentObject var router: Router
    @Binding var isShowingSearchModuleView: Bool
    @Binding var isShowingSettingTimeTableView: Bool
    @Binding var isShowingThemeView: Bool
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("NUS")
                        .font(.bold_8)
                        .foregroundColor(.heyGray6)
                        .padding(.horizontal, 5)
                        .padding(.vertical, 2)
                        .background(Color.heyDarkBlue)
                    
                    Text("AY2025/2026 sem1")
                        .font(.medium_12)
                        .foregroundColor(.heyGray2) //색상 확인
                }
                .padding(.bottom, 11)
                
                Text("A+++")
                    .font(.semibold_18)
                    .foregroundColor(.heyGray2) //색상 확인
            }
            
            Spacer()
            
            HStack {
                Button {
                    withAnimation {
                        isShowingSearchModuleView.toggle()
                    }
                } label: {
                    Image(uiImage: .icAdd.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .frame(width: 16, height: 16)
                        .tint(.heyGray6)
                        .padding(.trailing, 26)
                }
                
                Button {
                    withAnimation {
                        isShowingSettingTimeTableView.toggle()
                    }
                } label: {
                    Image(uiImage: .icSetting.withRenderingMode(.alwaysTemplate))
                        .resizable()
                        .frame(width: 20, height: 20)
                        .tint(.heyGray6)
                        .padding(.trailing, 23)
                }
                
                Button {
                    router.windowRouter.switch(to: .mypage)
                } label: {
                    Circle()
                        .frame(width: 31, height: 31)
                }
            }
        }
        .padding(.horizontal, 16)
        .sheet(isPresented: $isShowingSettingTimeTableView) {
            SettingTimeTableView(isShowingThemeView: $isShowingThemeView)
                .presentationDetents([.medium, .large, .height(256)])
                .presentationDragIndicator(.hidden)
        }
    }
}

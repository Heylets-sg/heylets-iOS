//
//  ThemeTopView.swift
//  DSKit
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain
import DSKit
import BaseFeatureDependency

struct ThemeTopView: View {
    @Binding var viewType: TimeTableViewType
    @ObservedObject var viewModel: ThemeViewModel
    
    var body: some View {
        VStack {
            ZStack {
                Text("Theme")
                    .font(.semibold_16)
                    .foregroundColor(.common.MainText.default)
                
                HStack {
                    Button {
                        withAnimation {
                            viewType = .main
                        }
                    } label: {
                        Image(uiImage: .icClose)
                            .resizable()
                            .frame(width: 16, height: 16)
                            .tint(.common.ButtonClose.default)
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.send(.saveButtonDidTap)
                        withAnimation {
                            viewType = .main
                        }
                    } label: {
                        Text("Save")
                            .font(.medium_16)
                            .foregroundColor(.common.Button.active)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 25)
            .padding(.bottom, 24)
        }
    }
}

struct ThemeListTopView: View {
    @Binding var viewType: TimeTableViewType
    @ObservedObject var viewModel: ThemeViewModel
    
    var body: some View {
        
        VStack {
            if !viewModel.state.inviteCodeViewHidden {
                ThemeInviteFriendView(height: 56.adjusted)
                    .onTapGesture {
                        viewModel.send(.inviteFriendViewDidTap)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 23.adjusted)
            }
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.themeList, id: \.self) { theme in
                        ThemeListCellView(
                            theme,
                            theme == viewModel.state.selectedTheme
                        )
                        .disabled(theme.unlocked)
                        .padding(.trailing, 20)
                        .onTapGesture {
                            viewModel.send(.themeButtonDidTap(theme))
                        }
                    }
                }
                .padding(.leading, 24)
            }
            .scrollIndicators(.hidden)
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
}

fileprivate struct ThemeListCellView: View {
    private let theme: Theme
    private let isSelected: Bool
    
    init(_ theme: Theme, _ isSelected: Bool) {
        self.theme = theme
        self.isSelected = isSelected
    }
    
    var body: some View {
        VStack {
            ZStack {
                if isSelected {
                    Circle()
                        .fill(Color.heyWhite)
                        .frame(width: 64, height: 64)
                        .overlay(Circle().stroke(Color.heyMain, lineWidth: 3.2))
                }
                
                QuarterCircleView(theme)
                    .frame(width: 56, height: 56)
            }
            .padding(.bottom, 6)
            
            Text(theme.themeName)
                .font(.medium_10)
                .foregroundColor(.common.MainText.default)
        }
        .frame(height: 95)
    }
}

struct ThemeInviteFriendView: View {
    let height: CGFloat
    var body: some View {
        HStack {
            Image(uiImage: .icLocked2)
                .resizable()
                .frame(width: 25, height: 28)
                .padding(.trailing, 20)
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Invite a friend and")
                    .font(.regular_14)
                
                Text("unlock more color theme")
                    .font(.semibold_14)
            }
            
            Spacer()
            
            Image(uiImage: .icNext)
                .resizable()
                .frame(width: 8, height: 16)
        }
        .padding(.vertical, height * 0.22)
        .padding(.leading, 24)
        .padding(.trailing, 27)
        .background(Color.common.Background.opacity60)
        .clipShape(Capsule())
    }
}

struct QuarterCircleView: View {
    var theme: Theme
    
    init(_ theme: Theme) {
        self.theme = theme
    }
    
    var body: some View {
        ZStack {
            // 첫 번째 1/4 (위쪽)
            QuarterCircle(color: theme.colorList[0], startAngle: 0, endAngle: 90)
            
            // 두 번째 1/4 (오른쪽)
            QuarterCircle(color: theme.colorList[1], startAngle: 90, endAngle: 180)
            
            // 세 번째 1/4 (아래쪽)
            QuarterCircle(color: theme.colorList[2], startAngle: 180, endAngle: 270)
            
            // 네 번째 1/4 (왼쪽)
            QuarterCircle(color: theme.colorList[3], startAngle: 270, endAngle: 360)
            
            // 세로 선
            Rectangle()
                .fill(Color.white)
                .frame(width: 2)
                .offset(x: 0) // 중심에 위치하도록 설정
            
            // 가로 선
            Rectangle()
                .fill(Color.white)
                .frame(height: 2)
                .offset(y: 0) // 중심에 위치하도록 설정
            
            if !theme.unlocked {
                Circle()
                    .fill(Color.common.Background.opacity60)
                
                Image(uiImage: .icLocked)
                    .resizable()
                    .frame(width: 14, height: 16)
            }
            
        }
    }
}

struct QuarterCircle: View {
    var color: String
    var startAngle: Double
    var endAngle: Double
    
    var body: some View {
        Path { path in
            let center = CGPoint(x: 28, y: 28)
            let radius: CGFloat = 28
            path.move(to: center)
            path.addArc(center: center, radius: radius, startAngle: .degrees(startAngle), endAngle: .degrees(endAngle), clockwise: false)
        }
        .fill(Color(hex: color))
    }
}

#Preview {
    let useCase = StubHeyUseCase.stub.timeTableUseCase
    return TimeTableView(
        viewModel: .init(
            .init(useCase),
            .init(useCase),
            .init(useCase, Router.default.navigationRouter),
            .init(useCase),
            Router.default.navigationRouter,
            Router.default.windowRouter,
            useCase)
    )
    .environmentObject(Router.default)
}


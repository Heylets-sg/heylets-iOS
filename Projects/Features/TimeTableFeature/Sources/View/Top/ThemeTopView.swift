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

struct ThemeTopView: View {
    @Binding var viewType: TimeTableViewType
    @ObservedObject var viewModel: ThemeViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation {
                        viewType = .main
                    }
                } label: {
                    Image(uiImage: .icClose)
                        .resizable()
                        .frame(width: 16, height: 16)
                }
                
                Spacer()
                
                Text("Theme")
                    .font(.semibold_16)
                    .foregroundColor(.heyGray1)
                
                Spacer()
                
                Button {
                    viewModel.send(.saveButtonDidTap)
                    withAnimation {
                        viewType = .main
                    }
                } label: {
                    Text("Save")
                        .font(.medium_16)
                        .foregroundColor(.heyGray1)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 26)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(viewModel.themeList, id: \.self) { theme in
                        ThemeListCellView(
                            theme,
                            theme == viewModel.state.selectedTheme
                        )
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
        ZStack {
            if isSelected {
                LinearGradient(
                    gradient: Gradient(colors: theme.colorList.map { Color(hex: $0) }),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .cornerRadius(10)
            } else {
                Color.clear
                    .cornerRadius(10)
            }
            
            VStack {
                QuarterCircleView(theme.colorList)
                    .frame(width: 56, height: 56)
                    .padding(.bottom, 6)
                
                Text(theme.name)
                    .font(.medium_10)
                    .foregroundColor(.heyGray1)
            }
        }
    }
}

struct QuarterCircleView: View {
    var colorList: [String]
    init(_ colorList: [String]) {
        self.colorList = colorList
    }
    var body: some View {
        ZStack {
            // 첫 번째 1/4 (위쪽)
            QuarterCircle(color: colorList[0], startAngle: 0, endAngle: 90)
            
            // 두 번째 1/4 (오른쪽)
            QuarterCircle(color: colorList[1], startAngle: 90, endAngle: 180)
            
            // 세 번째 1/4 (아래쪽)
            QuarterCircle(color: colorList[2], startAngle: 180, endAngle: 270)
            
            // 네 번째 1/4 (왼쪽)
            QuarterCircle(color: colorList[3], startAngle: 270, endAngle: 360)
            
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

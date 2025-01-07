//
//  ThemeTopView.swift
//  DSKit
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import DSKit

struct Theme: Hashable {
    var colorList: [String]
    var name: String
}

extension Theme {
    static var 라일락: Self {
        Theme(
            colorList: ["#F9F2F7", "#F9E2F9", "#FCD3F9", "#EBC9F9"],
            name: "LILAC")
    }
    
    static var 오트: Self {
        Theme(
            colorList: ["#F6F5F1", "#EEEAE2", "#E4E0DB", "#C8C2BD"],
            name: "OAT")
    }
    
    static var 에버그린: Self {
        Theme(
            colorList: ["#E5EEED", "#C9D5D1", "#ACC3BD", "#6E918D"],
            name: "EVERGREEN")
    }
    
    static var 베이비블루: Self {
        Theme(
            colorList: ["#F7FBFC", "#D6E6F2", "#B9D7EA", "#A2C7DE"],
            name: "BABY_BLUE")
    }
    
    static var 베이지: Self {
        Theme(
            colorList: ["#EEEBE6", "#E3D8CA", "#E8D9C6", "#CDB199"],
            name: "BEIGE")
    }
    
}


struct ThemeTopView: View {
    @Binding var viewType: TimeTableViewType
    
    let themeList: [Theme] = [.라일락, .오트, .에버그린, .베이비블루, .베이지]
    
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
                    ForEach(themeList, id: \.self) { theme in
                        ThemeListCellView(theme)
                            .padding(.trailing, 20)
                    }
                }
                .padding(.leading, 24)
            }
            .scrollIndicators(.hidden)
        }
    }
}

fileprivate struct ThemeListCellView: View {
    private let theme: Theme
    
    init(_ theme: Theme) {
        self.theme = theme
    }
    var body: some View {
        VStack {
            Button {
                
            } label: {
                VStack {
                    QuarterCircleView(colorList: theme.colorList)
                        .frame(width: 56, height: 56)
                        .padding(.bottom, 6)
                    
                    Text(theme.name)
                        .font(.medium_10)
                        .foregroundColor(.heyGray1)
                }
            }
        }
    }
}

struct QuarterCircleView: View {
    var colorList: [String]
    init(colorList: [String]) {
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

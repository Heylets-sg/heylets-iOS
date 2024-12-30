//
//  ThemeTopView.swift
//  DSKit
//
//  Created by 류희재 on 12/27/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

struct Theme: Hashable {
    var image: UIImage
    var name: String
}

struct ThemeTopView: View {
    @Binding var viewType: TimeTableViewType
    
    let themeList: [Theme] = [
        .init(image: .theme1, name: "theme1"),
        .init(image: .theme2, name: "theme2"),
        .init(image: .theme3, name: "theme3"),
        .init(image: .theme4, name: "theme4"),
        .init(image: .theme5, name: "theme5")
    ]
    
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
                    Image(uiImage: theme.image)
                        .resizable()
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

//#Preview {
//    ThemeTopView()
//}

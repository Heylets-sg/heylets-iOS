//
//  TabBarView.swift
//  DSKit
//
//  Created by 류희재 on 2/28/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

enum TabType {
    case timeTable
    case todo
    case my
    
    var image: UIImage {
        switch self {
        case .timeTable:
            return .tabTimeTable
        case .todo:
            return .tabTodo
        case .my:
            return .tabMypage
        }
    }
    
    var title: String {
        switch self {
        case .timeTable:
            return "Timetable"
        case .todo:
            return "To do"
        case .my:
            return "My"
        }
    }
    
}

public struct TabBarView: View {
    public var timeTableAction: (() -> Void)?
    public var todoAction: (() -> Void)?
    public var mypageAction: (() -> Void)?
    
    public init(
        timeTableAction: ((() -> Void))? = nil,
        todoAction: (() -> Void)? = nil,
        mypageAction: (() -> Void)? = nil
    ) {
        self.timeTableAction = timeTableAction
        self.todoAction = todoAction
        self.mypageAction = mypageAction
    }
    
    public var body: some View {
        VStack {
            Spacer()
            HStack {
                TabItemView(.timeTable)
                    .onTapGesture {
                        guard let timeTableAction else { return }
                        timeTableAction()
                    }
                    .padding(.trailing, 88)
                
                TabItemView(.todo)
                    .onTapGesture {
                        guard let todoAction else { return }
                        todoAction()
                    }
                    .padding(.trailing, 88)
                
                TabItemView(.my)
                    .onTapGesture {
                        guard let mypageAction else { return }
                        mypageAction()
                    }
            }
            .shadow(
                color: Color(hex: "#000000").opacity(0.06),
                radius: 17.2,
                x: 0,
                y: 2
            )
            .padding(.horizontal, 58)
            .padding(.top, 16)
            .padding(.bottom, 30)
            .frame(height: 86)
            .background(Color.heyWhite)
        }
    }
    
}

struct TabItemView: View {
    private let tabType: TabType
    
    init(_ tabType: TabType) {
        self.tabType = tabType
    }
    
    var body: some View {
        VStack {
            Image(uiImage: tabType.image)
                .resizable()
                .frame(width: 23, height: 23)
                .padding(.bottom, 6)
            
            Text(tabType.title)
                .font(.semibold_10)
                .foregroundColor(Color.init(hex: "#D2D2D2"))
        }
    }
}

#Preview {
    TabBarView()
}

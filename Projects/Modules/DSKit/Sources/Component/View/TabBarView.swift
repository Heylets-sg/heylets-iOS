//
//  TabBarView.swift
//  DSKit
//
//  Created by 류희재 on 2/28/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI
import Core

enum TabType {
    case timeTable
    case todo
    case my
    
    var image: Image {
        switch self {
        case .timeTable: return .tabTimeTable
        case .todo: return .tabTodo
        case .my: return .tabMypage
        }
    }
    
    var title: String {
        switch self {
        case .timeTable: return "Timetable"
        case .todo: return "To do"
        case .my: return "My"
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
            HStack {
                TabItemView(.timeTable, timeTableAction == nil)
                    .onTapGesture {
                        guard let timeTableAction else { return }
                        timeTableAction()
                    }
                    .frame(width: 50)
                
                Spacer()
                
                TabItemView(.todo, todoAction == nil)
                    .onTapGesture {
                        guard let todoAction else { return }
                        todoAction()
                    }
                    .frame(width: 28)
                
                Spacer()
                
                TabItemView(.my, false)
                    .onTapGesture {
                        guard let mypageAction else { return }
                        mypageAction()
                    }
                    .frame(width: 22)
            }
            .padding(.leading, 48)
            .padding(.trailing, 62)
            .padding(.top, 7.adjusted)
            .padding(.bottom, 34.adjusted)
            .background(Color.timeTableMain.tabNavigator)
            .ignoresSafeArea()
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        
        .shadow(
            color: Color.heyBlack.opacity(0.06),
            radius: 17.2,
            x: 0,
            y: 2
        )
    }
    
}

struct TabItemView: View {
    private let isFilled: Bool
    private let tabType: TabType
    
    init(
        _ tabType: TabType,
        _ isFilled: Bool
    ) {
        self.tabType = tabType
        self.isFilled = isFilled
    }
    
    var body: some View {
        VStack {
            tabType.image
                .resizable()
                .frame(width: 23, height: 23)
                .foregroundColor(
                    isFilled
                    ? .timeTableMain.Navigator.iconActive
                    : .timeTableMain.Navigator.iconUnActive
                )
            
            Text(tabType.title)
                .font(.semibold_10)
                .foregroundColor(
                    isFilled
                    ? .timeTableMain.Navigator.iconActive
                    : .timeTableMain.Navigator.iconUnActive
                )
        }
    }
}

#Preview {
    TabBarView()
}

//
//  TodoView.swift
//  TodoFeature
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI
import DSKit
import Domain
import BaseFeatureDependency

public struct TodoView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: TodoViewModel
    
    public init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
    }
    
    
    public var body: some View {
        VStack(alignment: .leading) {
            Text("Things to do")
                .font(.semibold_18)
                .foregroundColor(.heyGray1)
                .padding(.leading, 16)
                .padding(.bottom, 41)
                .padding(.top, 81)
            
            ScrollView {
                VStack {
                    ForEach(viewModel.group, id: \.self) { group in
                        TodoGroupView(group: group)
                    }
                }
                .padding(.horizontal, 24)
            }
            .scrollIndicators(.hidden)
        }
        .ignoresSafeArea()
    }
}

public struct TodoGroupView: View {
    private var group: TodoGroup
    
    public init(group: TodoGroup) {
        self.group = group
    }
    
    public var body: some View {
        VStack {
            HStack {
                Text(group.name)
                    .font(.semibold_14)
                    .foregroundStyle(Color.init(hex: "#3D3D3D"))
                
                Spacer()
                
                Button {
                } label: {
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 13, height: 3)
                        .padding(.trailing, 4)
                }
            }
            .padding(.bottom, 8)
            
            VStack {
                ForEach(group.items, id: \.self) { item in
                    TodoItemView(item: item)
                        .padding(.bottom, 8)
                }
            }
        }
    }
}

public struct TodoItemView: View {
    private var item: TodoItem
    
    public init(item: TodoItem) {
        self.item = item
    }
    
    public var body: some View {
        VStack {
            HStack(spacing: 0) {
                Button {
                    
                } label: {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.blue)
                        .frame(width: 16, height: 16)
                }
                .padding(.leading, 20)
                .padding(.trailing, 12)
                
                Text(item.content)
                    .font(.medium_14)
                    .foregroundStyle(Color.init(hex: "#4A4A4A"))
                    .lineLimit(2)
                    .background(Color.green)
                    .layoutPriority(1)
                
                Spacer()
                    .frame(minWidth: 23)
                
            }
            .padding(.vertical, 20)
        }
        .background(Color.init(hex: "#F7F7F7"))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


#Preview {
    TodoView(viewModel: .init(windowRouter: Router.default.windowRouter))
        .environmentObject(Router.default)
}

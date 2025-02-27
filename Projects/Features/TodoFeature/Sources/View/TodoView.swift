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
        ZStack {
            VStack(alignment: .leading) {
                Text("Things to do")
                    .font(.semibold_18)
                    .foregroundColor(.heyGray1)
                    .padding(.leading, 16)
                    .padding(.bottom, 41)
                    .padding(.top, 81)
                
                ScrollView {
                    VStack {
                        ForEach(viewModel.groupList, id: \.self) { group in
                            TodoGroupView(group: group)
                                .padding(.bottom, 16)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 36)
                    
                    Button {
                        
                    } label: {
                        Image(uiImage: .icAddGroup)
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.bottom, 123)
                    }
                }
                .scrollIndicators(.hidden)
            }
            .ignoresSafeArea()
            .onAppear {
                viewModel.send(.onAppear)
            }
            
            TabBarView(
                timeTableAction: { viewModel.send(.gotoTimeTable) },
                mypageAction: { viewModel.send(.gotoMyPage) }
            )
        }
    }
}

public struct TodoGroupView: View {
    private var group: TodoGroup
    
    public init(group: TodoGroup) {
        self.group = group
    }
    
    public var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text(group.name)
                        .font(.semibold_14)
                        .foregroundStyle(Color.init(hex: "#3D3D3D"))
                    
                    Spacer()
                    
                    Button {
                    } label: {
                        Image(uiImage: .icEtc)
                            .frame(width: 13, height: 3)
                            .padding(.trailing, 4)
                    }
                }
                .padding(.bottom, 8)
                
                VStack {
                    ForEach(group.items, id: \.id) { item in
                        TodoItemView(item: item)
                            .padding(.bottom, 8)
                    }
                    
                    HStack {
                        Image(uiImage: .icPlus)
                            .frame(width: 10, height: 10)
                            .padding(.leading, 23)
                            .padding(.trailing, 12)
                            .padding(.vertical, 23)
                        
                        Text("Add a task")
                            .font(.medium_12)
                            .foregroundStyle(Color.init(hex: "#B8B8B8"))
                        
                        Spacer()
                    }
                    .background(Color.init(hex: "#F7F7F7"))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .onTapGesture {
                        print("아이템 추가")
                    }
                }
            }
            EtcGroupView()
        }
    }
}

public struct TodoItemView: View {
    let item: TodoItem
    
    @State private var showDeleteButton: Bool = false
    @State private var offsetX: CGFloat = 0  // 드래그로 이동하는 거리
    private let threshold: CGFloat = 72      // 스와이프해서 완전히 열리는 기준
    
    public var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 0) {
                    Button {
                        
                    } label: {
                        Image(uiImage: item.completed
                              ? .icCompleted
                              : .icBlank
                        )
                        .frame(width: 16, height: 16)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 12)
                    .offset(x: offsetX) // 드래그로 이동하는 거리만큼 x 좌표를 옮김
                    
                    Text(item.content)
                        .font(.medium_14)
                        .foregroundStyle(Color.init(hex: "#4A4A4A"))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .layoutPriority(1)
                        .offset(x: offsetX) // 드래그로 이동하는 거리만큼 x 좌표를 옮김
                    
                    
                    Spacer()
                        .frame(minWidth: 23)
                        .offset(x: offsetX) // 드래그로 이동하는 거리만큼 x 좌표를 옮김
                }
                .padding(.vertical, 20)
            }
            .background(Color.init(hex: "#F7F7F7"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            if showDeleteButton {
                HStack(spacing: 0) {
                    Spacer()
                    Button {
                        print("delete")
                    } label: {
                        Text("Delete")
                            .font(.medium_14)
                            .foregroundColor(.white)
                            .frame(width: threshold)
                            .frame(minHeight: 56, maxHeight: 80)
                            .background(Color.red)
                        
                    }
                    .cornerRadius(8, corners: [.bottomRight, .topRight])
                }
            } else {
                EmptyView()
            }
        }
        .gesture( // 드래그 제스처
            DragGesture()
                .onChanged { value in
                    // 왼쪽으로 스와이프할 때만 offset을 업데이트 (value.translation.width < 0)
                    if value.translation.width < 0 {
                        // threshold보다 더 이동하지 않도록 제한
                        offsetX = max(value.translation.width, -threshold)
                    }
                }
                .onEnded { value in
                    // 일정 거리 이상(예: -threshold / 2) 스와이프하면 버튼이 고정되어 보이게
                    if value.translation.width < -threshold / 2 {
                        offsetX = -threshold
                        showDeleteButton = true
                    } else {
                        offsetX = 0
                        showDeleteButton = false
                    }
                }
        )
        .animation(.easeOut, value: offsetX)
    }
}

public struct EtcGroupView: View {
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Button {
                        
                    } label: {
                        Text("Delete group")
                            .font(.medium_14)
                            .foregroundColor(.heyGray1)
                    }
                    .padding(.bottom, 27)
                    
                    Button {
                        
                    } label: {
                        Text("Change name")
                            .font(.medium_14)
                            .foregroundColor(.heyGray1)
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 32)
                .padding(.vertical, 20)
                .background(Color.heyWhite)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(
                    color: Color(hex: "#9C9C9C").opacity(0.34),
                    radius: 25.5,
                    x: 0,
                    y: 4
                )
            }
            Spacer()
        }
        .padding(.top, 36)
    }
}


//#Preview {
//    let useCase = StubHeyUseCase.stub.todoUseCase
//    TodoView(viewModel: .init(windowRouter: Router.default.windowRouter, useCase: useCase))
//        .environmentObject(Router.default)
//}

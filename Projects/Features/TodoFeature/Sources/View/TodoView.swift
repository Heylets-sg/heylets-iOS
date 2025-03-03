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
                    .padding(.top, 81)
                    .padding(.bottom, 41)
                
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.groupList, id: \.self) { group in
                            TodoGroupView(
                                group: group,
                                viewModel: viewModel
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 36)
                    
                    Button {
                        viewModel.send(.addGroupButtonDidTap)
                    } label: {
                        Image(uiImage: .icAddGroup)
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(.bottom, 209)
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
            
            TodoAddItemView(
                title: "Enter name",
                content: $viewModel.state.editGroupName.1,
                groupId: 1,
                primaryAction: ("Close", .gray, { viewModel.send(.closeButtonDidTap) }),
                secondaryAction: ("Ok", .primary, { viewModel.send(.changeGroupName) })
            )
            .hidden(!viewModel.state.showItemAlertView)
        }
    }
}

public struct TodoGroupView: View {
    private var group: TodoGroup
    private let viewModel: TodoViewModel
    @State var showEtcView: Bool = false
    
    public init(
        group: TodoGroup,
        viewModel: TodoViewModel
    ) {
        self.group = group
        self.viewModel = viewModel
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
                        showEtcView.toggle()
                    } label: {
                        Image(uiImage: .icEtc)
                            .frame(width: 13, height: 3)
                            .padding(.trailing, 4)
                    }
                    .padding(.all, 5)
                }
                .padding(.bottom, 8)
                
                
                ScrollView {
                    
                
//                VStack(spacing: 8) {
                    ForEach(group.items, id: \.id) { item in
                        TodoItemView(
                            groupId: group.id,
                            item: item,
                            viewModel: viewModel
                        )
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
                        viewModel.send(.addItem(group.id))
                    }
//                }
                Spacer()
            }
            }
            
            EtcGroupView(
                deleteGroupAction: { viewModel.send(.deleteGroupButtonDidTap(group.id)) },
                changeGroupNameAction: { viewModel.send(.changeGroupNameButtonDidTap(group.id)) }
            )
            .hidden(!showEtcView)
        }
    }
}

public struct TodoItemView: View {
    private let groupId: Int
    private let item: TodoItem
    private let viewModel: TodoViewModel
    
    public init(
        groupId: Int,
        item: TodoItem,
        viewModel: TodoViewModel
    ) {
        self.groupId = groupId
        self.item = item
        self.viewModel = viewModel
    }
    
    @State private var showDeleteButton: Bool = false
    @State private var editMode: Bool = false
    @State private var content: String = ""  // ✅ 초기화 수정
    @State private var offsetX: CGFloat = 0
    private let threshold: CGFloat = 72
    
    public var body: some View {
        ZStack {
            VStack {
                HStack(spacing: 0) {
                    Button {
                        viewModel.send(.toggleItemCompletedButtonDidTap(item.id))
                    } label: {
                        Image(uiImage: item.completed ? .icCompleted : .icBlank)
                            .frame(width: 16, height: 16)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 12)
                    .offset(x: offsetX)
                    
                    if editMode {
                        TextField(
                            "",
                            text: $content,
                            prompt: Text(item.content)
                                .font(.medium_14)
                                .foregroundColor(.init(hex: "#B8B8B8"))
                        )
                        .font(.medium_14)
                        .foregroundStyle(Color.init(hex: "#4A4A4A"))
                        .offset(x: offsetX)
                        .onSubmit {
                            viewModel.send(.editItem(item.id, content))
                            editMode = false
                        }
                        .submitLabel(.done) // ✅ 엔터 키 입력 가능하도록 설정
                    } else {
                        Text(item.content)
                            .font(.medium_14)
                            .foregroundStyle(Color.init(hex: "#4A4A4A"))
//                            .lineLimit(2)
                            .frame(width: 271, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .layoutPriority(1)
                            .offset(x: offsetX)
                    }
                    Spacer()
                        .frame(minWidth: 23)
                        .offset(x: offsetX)
                }
                .padding(.vertical, 20)
            }
            .frame(minHeight: 56, maxHeight: 81)
            .background(Color.init(hex: "#F7F7F7"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            GeometryReader { geometry in
                if showDeleteButton {
                    HStack(spacing: 0) {
                        Spacer()
                        Button {
                            viewModel.send(.deleteItemButtonDidTap(item.id))
                        } label: {
                            Text("Delete")
                                .font(.medium_14)
                                .foregroundColor(.white)
                                .frame(width: threshold)
                                .frame(minHeight: 56, maxHeight: 81)
                                .background(Color.red)
                        }
                        .cornerRadius(8, corners: [.bottomRight, .topRight])
                    }
                }
            }
            
        }
        .onTapGesture {
            editMode = true // ✅ 한 번 탭하면 편집 모드로 전환
        }
        .gesture(
            DragGesture()
                .onChanged { value in
                    if value.translation.width < 0 {
                        offsetX = max(value.translation.width, -threshold)
                    }
                }
                .onEnded { value in
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
    private let deleteGroupAction: (() -> Void)
    private let changeGroupNameAction: (() -> Void)
    
    init(
        deleteGroupAction: @escaping () -> Void,
        changeGroupNameAction: @escaping () -> Void
    ) {
        self.deleteGroupAction = deleteGroupAction
        self.changeGroupNameAction = changeGroupNameAction
    }
    public var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Button {
                        deleteGroupAction()
                    } label: {
                        Text("Delete group")
                            .font(.medium_14)
                            .foregroundColor(.heyGray1)
                    }
                    .padding(.bottom, 27)
                    
                    Button {
                        changeGroupNameAction()
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


#Preview {
    let useCase = StubHeyUseCase.stub.todoUseCase
    return TodoView(
        viewModel: .init(
            windowRouter: Router.default.windowRouter,
            useCase: useCase
        )
    )
    .environmentObject(Router.default)
}

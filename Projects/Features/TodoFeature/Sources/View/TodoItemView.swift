//
//  TodoItemView.swift
//  TodoFeature
//
//  Created by 류희재 on 3/4/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain

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
    @State private var content: String = ""
    @State private var offsetX: CGFloat = 0
    private let threshold: CGFloat = 72
    @FocusState private var isKeyboardActive: Bool
    
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
                        .focused($isKeyboardActive)
                        .font(.medium_14)
                        .foregroundStyle(Color.init(hex: "#4A4A4A"))
                        .frame(width: 271, alignment: .leading)
                        .offset(x: offsetX)
                        .onSubmit {
                            viewModel.send(.editItem(item.id, content))
                            editMode = false
                        }
                        .submitLabel(.done)
                        .onAppear {
                            isKeyboardActive = true
                        }
                    } else {
                        Text(item.content)
                            .font(.medium_14)
                            .foregroundStyle(Color.init(hex: "#4A4A4A"))
                            .lineLimit(2)
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
            editMode = true
            viewModel.state.hiddenTabBar = false
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

public struct TodoAddItemView: View {
    private let viewModel: TodoViewModel
    private let groupId: Int
    @State private var editMode: Bool = false
    @State private var content: String = ""
    @FocusState private var isKeyboardActive: Bool
    
    init(
        viewModel: TodoViewModel,
        groupId: Int
    ) {
        self.viewModel = viewModel
        self.groupId = groupId
    }
    
    public var body: some View {
        VStack {
            if editMode {
                HStack(spacing: 0) {
                    Button {
                    } label: {
                        Image(uiImage: .icBlank)
                            .frame(width: 16, height: 16)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 12)
                    
                    TextField(
                        "",
                        text: $content,
                        prompt: Text("Add a task")
                            .font(.medium_12)
                            .foregroundColor(.init(hex: "#B8B8B8"))
                    )
                    .focused($isKeyboardActive)
                    .font(.medium_12)
                    .foregroundStyle(Color.init(hex: "#4A4A4A"))
                    .onSubmit {
                        viewModel.send(.addItem(groupId, content))
                        editMode = false
                    }
                    .submitLabel(.done)
                }
                .onAppear {
                    isKeyboardActive = true
                }
                .padding(.vertical, 20)
                .frame(height: 56)
            } else {
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
                .onTapGesture {
                    viewModel.state.hiddenTabBar = true
                    editMode = true
                }
            }
        }
        .background(Color.init(hex: "#F7F7F7"))
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .frame(height: 56)
        
    }
}


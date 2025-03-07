//
//  TodoGroupView.swift
//  TodoFeature
//
//  Created by 류희재 on 3/4/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import Domain
import DSKit

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
                HStack(spacing: 0) {
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
                    ForEach(group.items, id: \.id) { item in
                        TodoItemView(
                            groupId: group.id,
                            item: item,
                            viewModel: viewModel
                        )
                        .onTapGesture {
                            viewModel.send(.itemDidTap(item.id))
                        }
                        .padding(.bottom, 8)
                    }
                    
                    TodoAddItemView(
                        viewModel: viewModel,
                        content: Binding(
                            get: { viewModel.newItem.content },
                            set: { viewModel.newItem.content = $0 }
                            ),
                        isEditMode: group.isAddItemMode,
                        groupId: group.id
                    )
                }
                .frame(minWidth: 342)
            }
            
            if showEtcView {
                EtcGroupView(
                    deleteGroupAction: { viewModel.send(.deleteGroupButtonDidTap(group.id)) },
                    changeGroupNameAction: { viewModel.send(.changeGroupNameButtonDidTap(group.id)) }
                )
                .hidden(!showEtcView)
                .padding(.top, 36)

            } else {
                EmptyView()
            }
        }
        .padding(.horizontal, 24)
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
    }
}

extension UIResponder {
    @objc static func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

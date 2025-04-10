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
                        .foregroundColor(.common.MainText.default)
                    
                    Spacer()
                    
                    Menu {
                        Button {
                            viewModel.send(.deleteGroupButtonDidTap(group.id))
                        } label: {
                            Text("Delete group")
                                .font(.medium_14)
                                .foregroundColor(.common.MainText.default)
                        }
                        .padding(.bottom, 27)
                        
                        Button {
                            viewModel.send(.changeGroupNameButtonDidTap(group.id))
                        } label: {
                            Text("Change name")
                                .font(.medium_14)
                                .foregroundColor(.common.MainText.default)
                        }
                        
                    } label: {
                        HStack {
                            Image(uiImage: .icEtc)
                                .resizable()
                                .frame(width: 13, height: 3)
                                .foregroundColor(.common.Placeholder.default)
                        }
                        .padding(.leading, 20)
                        .padding(.vertical, 20)
                        
                    }
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
        }
        .padding(.horizontal, 24)
    }
}


extension UIResponder {
    @objc static func resignFirstResponder() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

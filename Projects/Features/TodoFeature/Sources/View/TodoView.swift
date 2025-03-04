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
            
            TodoChangeGroupNameAlertView(
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

//
//  TodoView.swift
//  TodoFeature
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit
import Domain

public struct TodoView: View {
    @EnvironmentObject var container: Router
    @ObservedObject var viewModel: TodoViewModel
    
    public init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Things to do")
                            .font(.semibold_18)
                            .foregroundColor(.heyGray1)
                            .padding(.leading, 16)
                            .padding(.top, 81)
                            .padding(.bottom, 12)
                        
                        Spacer()
                    }

                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.groupList, id: \.self) { group in
                                TodoGroupView(
                                    group: group,
                                    viewModel: viewModel
                                )
                            }
                        }
                        .loading(viewModel.state.isLoading)
                        .padding(.bottom, 36)
                        
                        HStack {
                            Spacer()
                            Button {
                                viewModel.send(.addGroupButtonDidTap)
                            } label: {
                                Image(uiImage: .icAddGroup)
                                    .resizable()
                                    .frame(width: 28, height: 28)
                            }
                            Spacer()
                        }
                        .padding(.bottom, 209)
                        
                    }
                    .scrollIndicators(.hidden)
                }
                
                .ignoresSafeArea()
                //            .padding(.horizontal, 16)
                .onAppear {
                    viewModel.send(.onAppear)
                }
                
                
                TabBarView(
                    timeTableAction: { viewModel.send(.gotoTimeTable) },
                    mypageAction: { viewModel.send(.gotoMyPage) }
                )
                .hidden(viewModel.state.hiddenTabBar)
                
                TodoChangeGroupNameAlertView(
                    title: "Enter name",
                    content: $viewModel.state.editGroupName.1,
                    primaryAction: ("Close", .gray, { viewModel.send(.closeButtonDidTap) }),
                    secondaryAction: ("Ok", .primary, { viewModel.send(.changeGroupName) })
                )
                .hidden(!viewModel.state.showItemAlertView)
            }
            .ignoresSafeArea()
            .heyAlert(
                isPresented: viewModel.state.showGuestDeniedAlert,
                loginButtonAction: {
                    viewModel.send(.gotoLogin)
                },
                notRightNowButton: {
                    viewModel.send(.notRightNowButtonDidTap)
                }
            )
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                viewModel.send(.hideKeyboard)
            }
        }
    }
}

//#Preview {
//    let useCase = StubHeyUseCase.stub.todoUseCase
//    return TodoView(
//        viewModel: .init(
//            windowRouter: Router.default.windowRouter,
//            useCase: useCase
//        )
//    )
//    .environmentObject(Router.default)
//}

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
    
    @State var text = ""
    @State private var keyboardHeight: CGFloat = 0
    
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
                            .foregroundColor(.common.MainText.else)
                            .padding(.leading, 16)
                        
                        Spacer()
                        
                        Button {
                            viewModel.send(.addGroupButtonDidTap)
                        } label: {
                            Image(uiImage: .icPlus)
                                .resizable()
                                .frame(width: 16, height: 16)
                                .tint(.timeTableMain.TimeTableInfo.topIcon)
                                .padding(.trailing, 24)
                        }
                    }
                    .padding(.top, 81.adjusted)
                    .padding(.bottom, 12.adjusted)
                    
                    if viewModel.groupList.isEmpty {
                        TodoEmptyView()
                            .background(.green)
                    } else {
                        TodoListView(viewModel: viewModel)
                            .background(.blue)
                    }
                }
                .ignoresSafeArea()
                .onAppear {
                    viewModel.send(.onAppear)
                }
                
                
                VStack {
                    Spacer()
                    TabBarView(
                        timeTableAction: { viewModel.send(.gotoTimeTable) },
                        mypageAction: { viewModel.send(.gotoMyPage) }
                    )
                    .frame(height: 82.adjusted)
                }
                
                HeyAlertTextFieldView(
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
                    viewModel.send(.loginButtonDidTap)
                },
                notRightNowButton: {
                    viewModel.send(.notRightNowButtonDidTap)
                }
            )
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                viewModel.send(.hideKeyboard)
            }
            .onReceive(Publishers.keyboardHeight) { height in
                keyboardHeight = height
            }
        }
    }
}

public struct TodoListView: View {
    @ObservedObject var viewModel: TodoViewModel
    
    public var body: some View {
        ScrollView {
            Spacer()
                .frame(height: 20.adjusted)
            VStack(spacing: 16.adjusted) {
                ForEach(viewModel.groupList, id: \.self) { group in
                    TodoGroupView(
                        group: group,
                        viewModel: viewModel
                    )
                }
            }
            .loading(viewModel.state.isLoading)
            .padding(.bottom, 36.adjusted)
            
            HStack {
                Spacer()
                Button {
                    viewModel.send(.addGroupButtonDidTap)
                } label: {
                    Image(uiImage: .icAddGroup)
                        .resizable()
                        .frame(width: 28, height: 28)
                        .tint(.todo.addtodo)
                }
                Spacer()
            }
            .padding(.bottom, 209.adjusted)
            
        }
        .scrollIndicators(.hidden)
    }
}

public struct TodoEmptyView: View {
    public var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                    .frame(height: 132.adjusted)
                
                Image(uiImage: .todoEmpty)
                    .resizable()
                    .frame(width: 103.adjusted, height: 113.adjusted)
                    .padding(.bottom, 36.adjusted)
                
                Text("Nothing here yet")
                    .font(.semibold_18)
                    .foregroundColor(.common.MainText.default)
                    .padding(.bottom, 12.adjusted)
                
                Text("Add your first to-do and\nstay on track!")
                    .font(.medium_16)
                    .foregroundColor(.common.Placeholder.default)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            Spacer()
        }
        
    }
}

// ✅ 키보드 높이를 감지하는 Publisher
import Combine

extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
                .map { $0.height },
            
            NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
        )
        .eraseToAnyPublisher()
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

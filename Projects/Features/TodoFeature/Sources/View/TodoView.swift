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
        GeometryReader { geometry in
            ZStack {
                Color.common.Background.default
                
                VStack(spacing: 0) {
                    headerView
                        .frame(width: geometry.size.width)
                        .padding(.top, 81.adjusted)
                        .padding(.bottom, 12.adjusted)
                    
                    ZStack(alignment: .top) {
                        if viewModel.groupList.isEmpty {
                            emptyContentView
                                .frame(width: geometry.size.width)
                        } else {
                            listContentView
                                .frame(width: geometry.size.width)
                        }
                    }
                    .frame(width: geometry.size.width)
                    
                    Spacer(minLength: 0)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                
                VStack {
                    Spacer()
                    TabBarView(
                        timeTableAction: { viewModel.send(.gotoTimeTable) },
                        mypageAction: { viewModel.send(.gotoMyPage) }
                    )
                    .frame(width: geometry.size.width, height: 82.adjusted)
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                
                HeyAlertTextFieldView(
                    title: "Enter name",
                    content: $viewModel.state.editGroupName.1,
                    primaryAction: ("Close", .gray, { viewModel.send(.closeButtonDidTap) }),
                    secondaryAction: ("Ok", .primary, { viewModel.send(.changeGroupName) })
                )
                .hidden(!viewModel.state.showItemAlertView)
            }
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(.all)
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
            endTextEditing()
            viewModel.send(.hideKeyboard)
        }
        .onReceive(Publishers.keyboardHeight) { height in
            keyboardHeight = height
        }
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
    
    // 헤더 뷰
    private var headerView: some View {
        HStack {
            Text("Things to do")
                .font(.semibold_18)
                .foregroundColor(.common.MainText.else)
                .padding(.leading, 16)
            
            Spacer()
            
            Button {
                viewModel.send(.addGroupButtonDidTap)
            } label: {
                Image.icPlus
                    .resizable()
                    .frame(width: 16, height: 16)
                    .tint(.timeTableMain.TimeTableInfo.topIcon)
                    .padding(.trailing, 24)
            }
        }
    }
    
    // 비어있는 상태 뷰
    private var emptyContentView: some View {
        ScrollView {
            VStack {
                Spacer()
                    .frame(height: 132.adjusted)
                
                Image.todoEmpty
                    .resizable()
                    .frame(width: 103.adjusted, height: 113.adjusted)
                    .padding(.bottom, 36.adjusted)
                    .hidden(viewModel.state.isLoading)
                
                Text("Nothing here yet")
                    .font(.semibold_18)
                    .foregroundColor(.common.MainText.default)
                    .padding(.bottom, 12.adjusted)
                    .hidden(viewModel.state.isLoading)
                
                Text("Add your first to-do and\nstay on track!")
                    .font(.medium_16)
                    .foregroundColor(.common.Placeholder.default)
                    .multilineTextAlignment(.center)
                    .hidden(viewModel.state.isLoading)
                
                Spacer()
            }
        }
        .scrollIndicators(.hidden)
    }
    
    // 목록 콘텐츠 뷰
    private var listContentView: some View {
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
                    Image.icAddGroup
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

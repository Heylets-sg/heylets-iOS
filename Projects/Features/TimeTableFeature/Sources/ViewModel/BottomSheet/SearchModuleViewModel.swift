//
//  SearchModuleViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/5/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

import BaseFeatureDependency
import DSKit
import Core

public class SearchModuleViewModel: ObservableObject {
    struct State {
        var reportMissingModuleAlertIsPresented: Bool = false
        var filteredItems: [LectureInfo] = []
    }
    
    enum Action {
        case reportMissingButtonDidTap
        case lectureCellDidTap
        case searchButtonDidTap
        case clearButtonDidTap
    }
    
    @Published var state = State()
    @Binding var viewType: TimeTableViewType
    @Binding var inValidregisterModuleIsPresented: InValidRegisterModelType
    @Published var lectureList: [LectureInfo] = [.stub, .stub, .stub, .stub, .stub]
    @Published var searchText = ""
    
    private let cancelBag = CancelBag()
    
    init(
        viewType: Binding<TimeTableViewType>,
        inValidregisterModuleIsPresented: Binding<InValidRegisterModelType>
    ) {
        self._viewType = viewType
        self._inValidregisterModuleIsPresented = inValidregisterModuleIsPresented
        state.filteredItems = lectureList
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .reportMissingButtonDidTap:
            state.reportMissingModuleAlertIsPresented = true
        case .lectureCellDidTap:
            viewType = .main
            //TODO: 이미 존재하는 모듈인지 확인
            //TODO: 추가하기 버튼 눌럿을때 -> 시간 충돌되면 alert 띄우기
            //            inValidregisterModuleIsPresented = (true, "The timetable has been saved as an image")
            //TODO: alert 뷰 string 값을 넣어둔다
            inValidregisterModuleIsPresented = (true, "This module is already exist")
        case .searchButtonDidTap:
            if searchText == "" {
                state.filteredItems = lectureList
            } else {
                state.filteredItems = lectureList.filter {
                    $0.code == searchText || $0.name == searchText
                }
            }
        case .clearButtonDidTap:
            searchText = ""
        }
    }
    
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        
    }
}


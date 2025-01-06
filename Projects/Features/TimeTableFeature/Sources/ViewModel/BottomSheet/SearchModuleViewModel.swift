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
        var selectedLecture: LectureInfo? = nil
    }
    
    enum Action {
        case onAppear
        case reportMissingButtonDidTap
        case lectureCellDidTap(LectureInfo)
        case searchButtonDidTap
        case clearButtonDidTap
        case addLectureButtonDidTap
    }
    
    @Published var state = State()
    @Published var viewType: TimeTableViewType = .main
    var isLectureInTimeTable: ((LectureInfo) -> Bool)?
    @Published var lectureList: [LectureInfo] = [
        .timetable_stub1,
        .search_stub,
        .search_stub1,
        .search_stub2,
        .search_stub3,
        .search_stub4,
        .search_stub5,
        .search_stub6,
        .search_stub7,
        .search_stub8,
        .search_stub9
    ]
    @Published var searchText = ""
    
    private let cancelBag = CancelBag()
    
    public init() {
        state.filteredItems = lectureList
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            //TODO: 전체 lecture 불러오는 API 호출
            break
        case .reportMissingButtonDidTap:
            state.reportMissingModuleAlertIsPresented = true
        case .lectureCellDidTap(let lecture):
            state.selectedLecture = lecture
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
        case .addLectureButtonDidTap:
            //            viewType = .main
            //TODO: 이미 존재하는 모듈인지 확인
            guard let lecture = state.selectedLecture, let isInTable = isLectureInTimeTable else { return }
            if isInTable(lecture) {
//                inValidregisterModuleIsPresented = (true, "This module is already exist")
                print("이미 TimeTable에 추가된 강의입니다.")
            } else {
                print("강의가 추가될 수 있습니다.")
                // 여기에서 추가 작업 실행
            }
            
            
            //TODO: 추가하기 버튼 눌럿을때 -> 시간 충돌되면 alert 띄우기
            //            inValidregisterModuleIsPresented = (true, "The timetable has been saved as an image")
            //TODO: alert 뷰 string 값을 넣어둔다
        }
    }
    
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        
    }
}


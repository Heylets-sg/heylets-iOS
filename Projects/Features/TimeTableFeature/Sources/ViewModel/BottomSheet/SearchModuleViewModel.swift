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
import Domain
import DSKit
import Core

public class SearchModuleViewModel: ObservableObject {
    struct State {
//        var isShowingAddCustomModuleView = false
        var filteredItems: [SectionInfo] = []
        var selectedLecture: SectionInfo? = nil
    }
    
    enum Action {
        case onAppear
        case lectureCellDidTap(SectionInfo)
        case searchButtonDidTap
        case clearButtonDidTap
        case addLectureButtonDidTap
//        case addCustomModuleButtonDidTap
    }
    
    @Published var state = State()
    var addLectureClosure: ((SectionInfo) -> Void)?
    @Published var lectureList: [SectionInfo] = [
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
    private let useCase: TimeTableUseCaseType
    
    public init(useCase: TimeTableUseCaseType) {
        self.useCase = useCase
        state.filteredItems = lectureList
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            //TODO: 전체 lecture 불러오는 API 호출
            useCase.getLectureList()
                .receive(on: RunLoop.main)
                .assign(to: \.lectureList, on: self)
                .store(in: cancelBag)
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
            guard let lecture = state.selectedLecture, let addLecture = addLectureClosure else { return }
            addLecture(lecture)
//        case .addCustomModuleButtonDidTap:
//            state.isShowingAddCustomModuleView.toggle()
        }
    }
    
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        
    }
}


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

private enum LectureFetchMode {
    case loadMore
    case fetch
    
    var isScrollToTop: Bool {
        switch self {
        case .loadMore: return false
        case .fetch: return true
        }
    }
}

@MainActor
public class SearchViewModel: ObservableObject {
    struct State {
        var selectedLecture: SectionInfo? = nil
        var isLoading: Bool = false
        var isScrollToTop: Bool = false
        var hasLoadedAll: Bool = false
    }
    
    enum Action {
        case onAppear
        case loadMoreData
        case closeButtonDidTap
        case lectureCellDidTap(Int)
        case searchButtonDidTap
        case clearButtonDidTap
        case addLectureButtonDidTap(Int)
        case updateFilters
    }
    
    @Published var state = State()
    public var filterViewModel: SearchFilterViewModel
    
    @Published var lectureList: [SectionInfo] = []
    @Published var filterInfo: FilterInfo = .init()
    
    private let cancelBag = CancelBag()
    private let useCase: SearchUseCaseType
    private let coordinator: any PresentCoordinatorType
    
    public var timeTableState: TimeTableState
    
    public init(
        _ useCase: SearchUseCaseType,
        _ timeTableState: TimeTableState,
        _ coordinator: any PresentCoordinatorType
    ) {
        self.useCase = useCase
        self.timeTableState = timeTableState
        self.coordinator = coordinator
        self.filterViewModel = .init(useCase)
        
        setupBindings()
    }
    
    @MainActor
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            fetchLectures()
            
        case .loadMoreData:
            filterInfo.page += 1
            fetchLectures(.loadMore)
            
        case .closeButtonDidTap:
            state.selectedLecture = nil
            filterInfo = .init()
            timeTableState.clearLecture()
            
        case .lectureCellDidTap(let index):
            state.selectedLecture = lectureList[index]
            timeTableState.selecttLecture(lectureList[index].timeTableCellInfo)
            
        case .searchButtonDidTap:
            fetchLectures()
            
        case .clearButtonDidTap:
            filterInfo.keyword = ""
            state.selectedLecture = nil
            timeTableState.clearLecture()
            fetchLectures()
            
        case .addLectureButtonDidTap(let index):
            let lecture = lectureList[index]
            Analytics.shared.track(.clickAddModule(
                courseCode: lecture.code ?? "",
                courseName: lecture.name,
                sectionId: lecture.id,
                professor: lecture.professor
            )
            )
            useCase.addSection(lecture.id, lecture.name, lecture.schedule.isEmpty)
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    Analytics.shared.track(.moduleAdded)
                    self?.coordinator.switchTo(.search)
                    self?.timeTableState.clearLecture()
                })
                .store(in: cancelBag)
            
        case .updateFilters:
            fetchLectures()
        }
    }
    
    private func fetchLectures(_ mode: LectureFetchMode = .fetch) {
        useCase.getLectureList(filterInfo)
            .receive(on: RunLoop.main)
            .assignLoading(to: \.state.isLoading, on: self)
            .sink(receiveCompletion: { [weak self] _ in
                guard let self else { return }
                if !self.filterInfo.keyword.isEmpty {
                    Analytics.shared.track(.moduleSearched)
                }
                self.state.isScrollToTop = mode.isScrollToTop
            }, receiveValue: { [weak self] data in
                self?.filterInfo.page = data.pageNum
                switch mode {
                case .loadMore:
                    self?.lectureList += data.lectureList
                case .fetch:
                    self?.lectureList = data.lectureList
                }
            })
            .store(in: cancelBag)
    }
}

extension SearchViewModel {
    @MainActor
    private func setupBindings() {
        filterViewModel.updateSelectedFilter = { [weak self] filterType, selectedItem in
            guard let self = self else { return }
            
            switch filterType {
                case .department: self.filterInfo.department = selectedItem
                case .semester: self.filterInfo.semester = selectedItem
                case .level: self.filterInfo.level = selectedItem
                case .other: self.filterInfo.keywordType = selectedItem
            }
            
            self.send(.updateFilters)
        }
        
        filterViewModel.getSelectedFilter = { [weak self] filterType in
            guard let self = self else { return nil }
            
            switch filterType {
                case .department: return self.filterInfo.department
                case .semester: return self.filterInfo.semester
                case .level: return self.filterInfo.level
                case .other: return self.filterInfo.keywordType
            }
        }
    }
}

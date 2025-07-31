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

public class SearchModuleViewModel: ObservableObject {
    struct State {
        var selectedLecture: SectionInfo? = nil
        var isLoading: Bool = false
        var isScrollToTop: Bool = false
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
    var selectLectureClosure: ((SectionInfo) -> Void)?
    var addLectureClosure: ((SectionInfo) -> Void)?
    public var filterViewModel: SearchFilterViewModel
    @Published var lectureList: [SectionInfo] = []
    @Published var filterInfo: FilterInfo = .init()
    
    private let cancelBag = CancelBag()
    private let useCase: SearchUseCaseType
    
    public init(_ useCase: SearchUseCaseType) {
        self.useCase = useCase
        self.filterViewModel = .init(useCase)
        
        setupBindings()
    }
    
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
            
        case .lectureCellDidTap(let index):
            state.selectedLecture = lectureList[index]
            guard let selectLecture = selectLectureClosure else { return }
            selectLecture(lectureList[index])
            
        case .searchButtonDidTap:
            fetchLectures()
            
        case .clearButtonDidTap:
            filterInfo.keyword = ""
            state.selectedLecture = nil
            fetchLectures()
            
        case .addLectureButtonDidTap(let index):
            guard let addLecture = addLectureClosure else { return }
            addLecture(lectureList[index])
            state.selectedLecture = nil
            
        case .updateFilters:
            filterInfo.page = 0
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
            }, receiveValue: { [weak self] lectureList in
                switch mode {
                case .loadMore:
                    self?.lectureList += lectureList
                case .fetch:
                    self?.lectureList = lectureList
                }
            })
            .store(in: cancelBag)
    }
}

extension SearchModuleViewModel {
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

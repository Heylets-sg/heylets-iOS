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
        var selectedLecture: SectionInfo? = nil
        var isLoading: Bool = false
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
    private let useCase: TimeTableUseCaseType
    
    public init(_ useCase: TimeTableUseCaseType) {
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
            fetchLectures()
            
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
    
    private func fetchLectures() {
        useCase.getLectureList(filterInfo)
            .receive(on: RunLoop.main)
            .assignLoading(to: \.state.isLoading, on: self)
            .handleEvents(receiveOutput: { [weak self] _ in
                if self?.filterInfo.keyword.isEmpty == false {
                    Analytics.shared.track(.moduleSearched)
                }
            })
            .sink(receiveValue: { [weak self] lectureList in
                self?.lectureList += lectureList
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

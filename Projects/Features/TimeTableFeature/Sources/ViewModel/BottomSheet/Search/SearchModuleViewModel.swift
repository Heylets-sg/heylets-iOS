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
        case lectureCellDidTap(SectionInfo)
        case searchButtonDidTap
        case clearButtonDidTap
        case addLectureButtonDidTap(SectionInfo)
        case updateFilters
    }
    
    @Published var state = State()
    var selectLectureClosure: ((SectionInfo) -> Void)?
    var addLectureClosure: ((SectionInfo) -> Void)?
    public var filterViewModel: SearchFilterViewModel
    @Published var lectureList: [SectionInfo] = []
    
    @Published var filterInfo: FilterInfo = .init()
    //    @Published var searchText = ""
    //
    //    // Changed from arrays to optional strings for single selection
    //    @Published var selectedDepartment: String? = nil
    //    @Published var selectedSemester: String? = nil
    //    @Published var selectedLevel: String? = nil
    //    @Published var selectedOther: String? = nil
    
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    
    public init(
        _ useCase: TimeTableUseCaseType
    ) {
        self.useCase = useCase
        self.filterViewModel = .init(useCase)
        
        setupBindings()
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            fetchLectures()
            
        case .lectureCellDidTap(let lecture):
            state.selectedLecture = lecture
            guard let selectLecture = selectLectureClosure else { return }
            selectLecture(lecture)
            
        case .searchButtonDidTap:
            fetchLectures()
            
        case .clearButtonDidTap:
            filterInfo.keyword = ""
            state.selectedLecture = nil
            fetchLectures()
            
        case .addLectureButtonDidTap(let lecture):
            guard let addLecture = addLectureClosure else { return }
            addLecture(lecture)
            state.selectedLecture = nil
            
        case .updateFilters:
            fetchLectures()
        }
    }
    
    private func fetchLectures() {
        useCase.getLectureList(.init())
            .receive(on: RunLoop.main)
            .assignLoading(to: \.state.isLoading, on: self)
            .handleEvents(receiveOutput: { [weak self] _ in
                if self?.filterInfo.keyword.isEmpty == false {
                    Analytics.shared.track(.moduleSearched)
                }
            })
            .assign(to: \.lectureList, on: self)
            .store(in: cancelBag)
    }
    
    private func observe() {
        $filterInfo
            .flatMap(useCase.getLectureList)
            .receive(on: RunLoop.main)
            .assignLoading(to: \.state.isLoading, on: self)
            .handleEvents(receiveOutput: { [weak self] _ in
                if self?.filterInfo.keyword.isEmpty == false {
                    Analytics.shared.track(.moduleSearched)
                }
            })
            .assign(to: \.lectureList, on: self)
            .store(in: cancelBag)
    }
}

extension SearchModuleViewModel {
    private func setupBindings() {
        filterViewModel.updateSelectedFilter = { [weak self] filterType, selectedItem in
            guard let self = self else { return }
            
            switch filterType {
            case .department:
                self.filterInfo.department = selectedItem
            case .semester:
                self.filterInfo.semester = selectedItem
            case .level:
                self.filterInfo.level = selectedItem
            case .other:
                self.filterInfo.other = selectedItem
            }
            self.send(.updateFilters)
        }
        
        // Updated to return single selection
        filterViewModel.getSelectedFilter = { [weak self] filterType in
            guard let self = self else { return nil }
            
            switch filterType {
            case .department:
                return self.filterInfo.department
            case .semester:
                return self.filterInfo.semester
            case .level:
                return self.filterInfo.level
            case .other:
                return self.filterInfo.other
            }
        }
    }
}

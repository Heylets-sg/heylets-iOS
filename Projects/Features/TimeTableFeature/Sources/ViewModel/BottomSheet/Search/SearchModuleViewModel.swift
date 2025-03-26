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
    @Published var searchText = ""
    
    @Published var selectedDepartments: [String] = []
    @Published var selectedSemesters: [String] = []
    @Published var selectedLevels: [String] = []
    @Published var selectedOthers: [String] = []
    
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    
    public init(
        _ useCase: TimeTableUseCaseType
    ) {
        self.useCase = useCase
        self.filterViewModel = .init(useCase)
        setupBindings()
    }
    
    private func setupBindings() {
        // Set up closure to receive selected filters from FilterViewModel
        filterViewModel.updateSelectedFilters = { [weak self] filterType, selectedItems in
            guard let self = self else { return }
            
            switch filterType {
            case .department:
                self.selectedDepartments = selectedItems
            case .semester:
                self.selectedSemesters = selectedItems
            case .level:
                self.selectedLevels = selectedItems
            case .other:
                self.selectedOthers = selectedItems
            }
            
            self.send(.updateFilters)
        }
        
        filterViewModel.getSelectedFilters = { [weak self] filterType in
            guard let self = self else { return [] }
            
            var selectedItems: [String] = []
            switch filterType {
            case .department:
                selectedItems = self.selectedDepartments
            case .semester:
                selectedItems = self.selectedSemesters
            case .level:
                selectedItems = self.selectedLevels
            case .other:
                selectedItems = self.selectedOthers
            }
            
            print("Getting selected filters for \(filterType): \(selectedItems)")
            return selectedItems
        }
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
            searchText = ""
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
        useCase.getLectureList(searchText)
            .receive(on: RunLoop.main)
            .assignLoading(to: \.state.isLoading, on: self)
            .handleEvents(receiveOutput: { [weak self] _ in
                if self?.searchText.isEmpty == false {
                    Analytics.shared.track(.moduleSearched)
                }
            })
            .assign(to: \.lectureList, on: self)
            .store(in: cancelBag)
    }
    
    // Helper method to get current filter status for UI display
    func getFilterStatus() -> String {
        var filterStatus = ""
        
        if !selectedDepartments.isEmpty {
            filterStatus += "Department: \(selectedDepartments.joined(separator: ", "))"
        }
        
        if !selectedSemesters.isEmpty {
            if !filterStatus.isEmpty { filterStatus += " | " }
            filterStatus += "Sem: \(selectedSemesters.joined(separator: ", "))"
        }
        
        if !selectedLevels.isEmpty {
            if !filterStatus.isEmpty { filterStatus += " | " }
            filterStatus += "Level: \(selectedLevels.joined(separator: ", "))"
        }
        
        if !selectedOthers.isEmpty {
            if !filterStatus.isEmpty { filterStatus += " | " }
            filterStatus += "Others: \(selectedOthers.joined(separator: ", "))"
        }
        
        return filterStatus
    }
}

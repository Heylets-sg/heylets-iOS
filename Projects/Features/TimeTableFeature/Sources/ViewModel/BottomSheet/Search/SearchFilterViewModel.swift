//
//  SearchFilterViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 3/24/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit
import Core

struct FilterItemType: Hashable {
    var id: UUID = UUID()
    var title: String
    var isSelected: Bool
}

enum ClassFilterType: CaseIterable {
    case department
    case semester
    case level
    case other
    
    var title: String {
        switch self {
        case .department: "Department"
        case .semester: "Sem"
        case .level: "Level"
        case .other: "Others"
        }
    }
}

public class SearchFilterViewModel: ObservableObject {
    struct State {
        var isPresented: Bool = false
    }
    
    enum Action {
        case onAppear
        case filterButtonDidTap(ClassFilterType)
        case backButtonDidTap
        case applyButtonDidTap
    }
    
    @Published var state = State()
    @Published var departmentList: [String] = []
    private let levelList: [String] = ["1", "2", "3", "4", "5", "6"]
    private let semesterList: [String] = ["TERM_1", "TERM_2"]
    
    @Published var filterType: ClassFilterType = .department
    @Published var filterList: [FilterItemType] = []
    
    // Closure for passing selected filters to parent ViewModel
    var updateSelectedFilters: ((ClassFilterType, [String]) -> Void)?
    
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    
    public init(
        _ useCase: TimeTableUseCaseType
    ) {
        self.useCase = useCase
    }
    
    // Get currently selected filters from parent view model
    var getSelectedFilters: ((ClassFilterType) -> [String])?
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getLectureDepartment()
                .receive(on: RunLoop.main)
                .assign(to: \.departmentList, on: self)
                .store(in: cancelBag)
            
        case .filterButtonDidTap(let type):
            filterType = type
            var tempArr: [String] = []
            switch type {
            case .department:
                tempArr = departmentList
            case .semester:
                tempArr = semesterList
            case .level:
                tempArr = levelList
            case .other:
                tempArr = []
            }
            
            // Get currently selected items for this filter type
            let currentlySelectedItems = getSelectedFilters?(type) ?? []
            
            // Create filter items with appropriate selection state
            filterList = tempArr.map { item in
                return FilterItemType(title: item, isSelected: currentlySelectedItems.contains(item))
            }
            
            // 선택된 항목들이 제대로 표시되는지 디버깅용 출력
            print("Filter type: \(type), Selected items: \(currentlySelectedItems)")
            print("Filter list with selection state: \(filterList.filter { $0.isSelected }.map { $0.title })")
            
            state.isPresented = true
            
        case .backButtonDidTap:
            state.isPresented = false
            
        case .applyButtonDidTap:
            let selectedItems = filterList.filter { $0.isSelected }.map { $0.title }
            if let updateSelectedFilters = updateSelectedFilters {
                updateSelectedFilters(filterType, selectedItems)
            }
            state.isPresented = false
        }
    }
}

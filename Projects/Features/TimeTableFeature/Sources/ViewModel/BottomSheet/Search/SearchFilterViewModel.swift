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
    
    // Closure for passing selected filter to parent ViewModel
    var updateSelectedFilter: ((ClassFilterType, String?) -> Void)?
    
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    
    public init(
        _ useCase: TimeTableUseCaseType
    ) {
        self.useCase = useCase
    }
    
    // Get currently selected filter from parent view model
    var getSelectedFilter: ((ClassFilterType) -> String?)?
    
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
            
            // Get currently selected item for this filter type
            let currentlySelectedItem = getSelectedFilter?(type)
            
            // Create filter items with appropriate selection state
            filterList = tempArr.map { item in
                return FilterItemType(title: item, isSelected: currentlySelectedItem == item)
            }
            
            // Debug output
            print("Filter type: \(type), Selected item: \(currentlySelectedItem ?? "none")")
            
            state.isPresented = true
            
        case .backButtonDidTap:
            state.isPresented = false
            
        case .applyButtonDidTap:
            // Get the single selected item or nil if none selected
            let selectedItem = filterList.first(where: { $0.isSelected })?.title
            
            if let updateSelectedFilter = updateSelectedFilter {
                updateSelectedFilter(filterType, selectedItem)
            }
            state.isPresented = false
        }
    }
}

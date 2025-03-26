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
    }
    
    enum Action {
        case onAppear
    }
    
    @Published var state = State()
    @Published var departmentList: [String] = []
    private let levelList: [String] = ["1", "2", "3", "4", "5", "6"]
    private let semesterList: [String] = ["TERM_1", "TERM_2"]
    
    
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    
    public init(
        _ useCase: TimeTableUseCaseType
    ) {
        self.useCase = useCase
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getLectureDepartment()
                .receive(on: RunLoop.main)
                .assign(to: \.departmentList, on: self)
                .store(in: cancelBag)
        }
    }
}



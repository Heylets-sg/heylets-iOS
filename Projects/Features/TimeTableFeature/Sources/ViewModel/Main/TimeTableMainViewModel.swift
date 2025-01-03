//
//  TimeTableMainViewModel.swift
//  TimeTableFeatureInterface
//
//  Created by 류희재 on 1/3/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import DSKit
import Core

public class TimeTableMainViewModel: ObservableObject {
    struct State {
        
    }
    
    enum Action {
        case onAppear
    }
    
    @Published var state = State()
    @Published var weekList: [Week] = Week.dayOfWeek
    @Published var timeTableCellList: [TimeTableCellInfo] = [.stub1, .stub2].createTimeTableCellList()
    
    private let cancelBag = CancelBag()
    
    public init() {
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            break
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
}



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
    @Published var weekList: [Week] = []
    @Published var timeTableCellList: [TimeTableCellInfo] = [.stub1, .stub2].createTimeTableCellList()
    
    private let cancelBag = CancelBag()
    
    public init() {
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            weekList = Week.weekDay
            for cell in timeTableCellList {
                if cell.schedule.day == .Sun {
                    weekList = Week.dayOfWeek
                    break
                }
                if cell.schedule.day == .Sat && !weekList.contains(.Sat) {
                    weekList.append(.Sat)
                }
            }
            print("weekList: \(weekList)")
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
}



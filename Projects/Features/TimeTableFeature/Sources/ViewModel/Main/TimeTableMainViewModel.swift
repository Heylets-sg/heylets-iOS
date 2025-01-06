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
        var timeTable: [[TimeTableCellInfo?]] = Array(repeating: Array(repeating: nil, count: 16), count: 5)
    }
    
    enum Action {
        case onAppear
    }
    
    @Published var state = State()
    @Published var weekList: [Week] = []
    @Published var timeTableCellList: [TimeTableCellInfo]
    
    private let cancelBag = CancelBag()
    
    init(lectureList: [LectureInfo]) {
        self.timeTableCellList = lectureList.createTimeTableCellList()
        
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
            setTimeTable()
        }
    }
    
    private func setTimeTable() {
        state.timeTable = Array(repeating: Array(repeating: nil, count: 16), count: weekList.count)
        for cell in timeTableCellList {
            if let weekIndex = weekList.firstIndex(of: cell.schedule.day) {
                for s in cell.slot {
                    state.timeTable[weekIndex][s.key] = cell
                }
            }
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
}



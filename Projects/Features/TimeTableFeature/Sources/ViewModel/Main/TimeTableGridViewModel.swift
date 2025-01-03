//
//  TimeTableGridViewModel.swift
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

public class TimeTableGridViewModel: ObservableObject {
    struct State {
        var timeTable: [[TimeTableCellInfo?]] = Array(repeating: Array(repeating: nil, count: 16), count: 5)
    }
    
    enum Action {
        case onAppear
    }
    
    @Published var state = State()
    @Published var timeTableCellList: [TimeTableCellInfo]
    @Published var weekList: [Week]
    
    private let cancelBag = CancelBag()
    
    init(timeTableCellList: [TimeTableCellInfo], weekList: [Week]) {
        self.timeTableCellList = timeTableCellList
        self.weekList = weekList
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            setTimeTable()
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
    }
    
    private func setTimeTable() {
        state.timeTable = Array(repeating: Array(repeating: nil, count: 16), count: weekList.count)
        
        for cell in timeTableCellList {
            let dayIndex = cell.schedule.day.index
            let startHour = cell.schedule.startHour - 9
            let endHour = cell.schedule.endHour - 9
            
            for h in startHour..<endHour {
                state.timeTable[dayIndex][h] = cell
            }
        }
    }
}


//public class TimeTableGridViewModel: ObservableObject {
//    struct State {
//        
//    }
//    
//    enum Action {
//        case onAppear
//    }
//    
//    @Published var state = State()
//    @Published var timeTableCellList: [TimeTableCellInfo] = [.stub1,.stub2].createTimeTableCellList()
//    
//    private let cancelBag = CancelBag()
//    
//    public init() {
//        
//        observe()
//    }
//    
//    func send(_ action: Action) {
//        switch action {
//        case .onAppear:
//            break
//        }
//    }
//    
//    private func observe() {
//        weak var owner = self
//        guard let owner else { return }
//        
//    }
//    
//    private func setTimeTable() {
//        var timeTableCellList: [TimeTableCellInfo] = [.stub1,.stub2].createTimeTableCellList()
//        
//        var timeTable: [[TimeTableCellInfo?]] = Array(repeating: Array(repeating: nil, count: 16), count: 7)
//        
//        for cell in timeTableCellList {
//            //요일 인덱스로 위치 설정
//            let dayIndex = cell.schedule.day.index
//            let startHour = cell.schedule.startHour-9
//            let endHour = cell.schedule.endHour-9
//            
//            for h in endHour...startHour {
//                timeTable[dayIndex][h] = cell
//            }
//            
//        }
//        
//    }
//}
//

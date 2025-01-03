//
//  DetailModuleInfoViewModel.swift
//  TimeTableFeatureInterface
//
//  Created by 류희재 on 1/2/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import DSKit
import Core

public class DetailModuleInfoViewModel: ObservableObject {
    struct State {
       
    }
    
    enum Action {
    }
    
    @Published var state = State()
    
    //TODO: 시간표 상세조희 서버통신으로 이 값 업데이트
    var moduleInfo = ModuleInfo(
        code: "ML0004",
        name: "Career and Entrepreneurial Development",
        schedule: [
            .init(day: "Mon", startTime: "12:00", endTime: "13:00", location: "SOE CR B1-2"),
            .init(day: "Thu", startTime: "09:00", endTime: "10:00", location: "SOE CR B1-2"),
        ],
        professor: "TO BE Announced",
        unit: 2
    )
    private let cancelBag = CancelBag()
    
    public init() {
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
}

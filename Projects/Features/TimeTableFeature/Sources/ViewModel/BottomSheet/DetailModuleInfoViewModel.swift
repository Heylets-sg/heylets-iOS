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
import Domain
import Core

public class DetailModuleInfoViewModel: ObservableObject {
    struct State {
       
    }
    
    enum Action {
    }
    
    @Published var state = State()
    
    //TODO: 시간표 상세조희 서버통신으로 이 값 업데이트
    public var moduleInfo: SectionInfo = .timetable_stub1
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

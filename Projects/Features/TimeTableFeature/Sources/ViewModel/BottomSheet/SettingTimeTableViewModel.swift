//
//  SettingTimeTableViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/7/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import DSKit
import Core

public class SettingTimeTableViewModel: ObservableObject {
    struct State {
       
    }
    
    enum Action {
        case shareURL
    }
    
    @Published var state = State()
    
    private let cancelBag = CancelBag()
    
    public init() {
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .shareURL:
            //TODO: ShareURL 복사
            break
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
}


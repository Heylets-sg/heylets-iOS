//
//  AddCustomModuleViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/6/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import DSKit
import Core

public class AddCustomModuleViewModel: ObservableObject {
    struct State {
        var weekPickerIsHidden = true
        var timePickerIsHidden = true
    }
    
    enum Action {
        case weekPickerButtonDidTap
        case timePickerButtonDidTap
        case addCustomModuleButtonDidTap
    }
    
    @Published var state = State()
    @Published var day = "Mon"
    @Published var time = "09:00 - 10:00"
    @Published var schedule: String = ""
    @Published var location: String = ""
    @Published var professor: String  = ""
    
    let dayofWeeks = Week.dayOfWeek
    let timeList: [String] = (9...23).map { hour in
        let start = String(format: "%02d:00", hour)
        let end = String(format: "%02d:00", hour + 1)
        return "\(start) - \(end)"
    }
    
    private let cancelBag = CancelBag()
    
    public init() {
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .weekPickerButtonDidTap:
            state.weekPickerIsHidden.toggle()
            state.timePickerIsHidden = true
        case .timePickerButtonDidTap:
            state.weekPickerIsHidden = true
            state.timePickerIsHidden.toggle()
        case .addCustomModuleButtonDidTap:
            //TODO: 커스텀 모듈 추가 API 호출
            print(day, time, schedule, location, professor)
            break
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
}



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
import Domain
import DSKit
import Core

public class AddCustomModuleViewModel: ObservableObject {
    struct State {
        var weekPickerIsHidden = true
        var timePickerIsHidden = true
        var isAddSuccess = false
    }
    
    enum Action {
        case weekPickerButtonDidTap
        case timePickerButtonDidTap
        case addCustomModuleButtonDidTap
    }
    
    
    @Published var state = State()
    @Published var day: Week = .Mon
    @Published var time = "09:00 - 10:00"
    @Published var schedule: String = ""
    @Published var location: String = ""
    @Published var professor: String  = ""
    
    let dayofWeeks = Week.dayOfWeek
    let timeList: [String] = (1...22).map { hour in
        let start = String(format: "%02d:00", hour)
        let end = String(format: "%02d:00", hour + 1)
        return "\(start) - \(end)"
    }
    
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    
    public init(_ useCase: TimeTableUseCaseType) {
        self.useCase = useCase
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
            let splitTime = splitTimeRange(time)
            let customModule: CustomModuleInfo = .init(
                title: schedule,
                classDay: day.fromWeek(),
                startTime: splitTime.0,
                endTime: splitTime.1,
                location: location == "" ? nil : location,
                professor: professor == "" ? nil : professor,
                memo: nil
            )
            useCase.addCustomModule(customModule)
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] _ in
                    self?.state.isAddSuccess = true
                })
                .store(in: cancelBag)
        }
    }
}

extension AddCustomModuleViewModel {
    func splitTimeRange(_ timeRange: String) -> (start: String, end: String) {
        let components = timeRange.components(separatedBy: " - ")
        let start = components[0]
        let end = components[1]
        
        return (start, end)
    }
}



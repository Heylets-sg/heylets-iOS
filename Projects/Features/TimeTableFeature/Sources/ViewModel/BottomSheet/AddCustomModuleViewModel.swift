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
        case weekPickerButtonDidTap(Week)
        case timePickerButtonDidTap(String)
        case saveCustomModuleButtonDidTap
    }
    
    
    @Published var state = State()
    @Published var day: Week = .Mon
    @Published var time = "09:00 - 10:00"
    @Published var schedule: String = ""
    @Published var location: String = ""
    @Published var professor: String  = ""
    
    let timeList: [String] = (1...22).flatMap { hour in
        [0, 30].map { minute in
            let start = String(format: "%02d:%02d", hour, minute)
            let endHour = hour + (minute == 30 ? 1 : 0)  // 30분이면 다음 시간으로 넘어감
            let endMinute = (minute + 30) % 60
            let end = String(format: "%02d:%02d", endHour, endMinute)
            return "\(start) - \(end)"
        }
    }
    
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    
    public init(_ useCase: TimeTableUseCaseType) {
        self.useCase = useCase
    }
    
    func send(_ action: Action) {
        switch action {
        case .weekPickerButtonDidTap(let week):
            self.day = week
            state.weekPickerIsHidden.toggle()
            state.timePickerIsHidden = true
            
        case .timePickerButtonDidTap(let time):
            self.time = time
            state.weekPickerIsHidden = true
            state.timePickerIsHidden.toggle()
            
        case .saveCustomModuleButtonDidTap:
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
                    Analytics.shared.track(.customModuleAdded)
                    self?.initInfo()
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
    
    func initInfo() {
        self.day = .Mon
        self.time = "09:00 - 10:00"
        self.schedule = ""
        self.location = ""
        self.professor = ""
    }
}



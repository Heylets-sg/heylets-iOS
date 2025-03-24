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
        var isMenuOpen = false
        var isAddSuccess = false
    }
    
    enum Action {
        case weekPickerButtonDidTap(Week)
        case saveCustomModuleButtonDidTap
    }
    
    
    @Published var state = State()
    @Published var day: Week = .Mon
    @Published var startTime = "09:00"
    @Published var endTime = "10:00"
    @Published var schedule: String = ""
    @Published var location: String = ""
    @Published var professor: String  = ""
    
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    
    public init(_ useCase: TimeTableUseCaseType) {
        self.useCase = useCase
    }
    
    func send(_ action: Action) {
        switch action {
        case .weekPickerButtonDidTap(let week):
            day = week
            
        case .saveCustomModuleButtonDidTap:
            let customModule: CustomModuleInfo = .init(
                title: schedule,
                classDay: day.fromWeek(),
                startTime: startTime,
                endTime: endTime,
                location: location == "" ? nil : location,
                professor: professor == "" ? nil : professor,
                memo: nil
            )
            Analytics.shared.track(.clickAddCustomModule(
                customModuleName: schedule,
                professor: professor ,
                location: location,
                day: day.fromWeek(),
                schedule: "\(startTime) ~ \(endTime)"
            )
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
    func initInfo() {
        self.day = .Mon
        self.schedule = ""
        self.location = ""
        self.professor = ""
    }
}



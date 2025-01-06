//
//  TimeTableViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/5/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

import BaseFeatureDependency
import DSKit
import Core

typealias InValidRegisterModelType = (Bool, String)

public class TimeTableViewModel: ObservableObject {
    struct State {
        var settingAlertType: TimeTableSettingAlertType? = nil
        var deleteModuleAlertIsPresented: Bool = false
        var inValidregisterModuleIsPresented: InValidRegisterModelType = (false, "")
        var reportMissingModuleAlertIsPresented: Bool = false
    }
    
    enum Action {
        case deleteModule
        case deleteModuleAlertCloseButtonDidTap
        case inValidregisterModuleAlertCloseButtonDidTap
        case settingAlertDismiss
    }
    
    @Published var state = State()
    private let cancelBag = CancelBag()
    
    public init() {
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .deleteModule:
            //TODO: 삭제 API 호출
            state.deleteModuleAlertIsPresented = false
        case .deleteModuleAlertCloseButtonDidTap:
            state.deleteModuleAlertIsPresented = false
        case .inValidregisterModuleAlertCloseButtonDidTap:
            state.inValidregisterModuleIsPresented = (false, "")
        case .settingAlertDismiss:
            state.settingAlertType = nil
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
}

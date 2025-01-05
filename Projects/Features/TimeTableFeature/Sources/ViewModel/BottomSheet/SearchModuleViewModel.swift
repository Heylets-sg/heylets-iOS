//
//  SearchModuleViewModel.swift
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

public class SearchModuleViewModel: ObservableObject {
    struct State {
        var reportMissingModuleAlertIsPresented: Bool = false
        var inValidregisterModuleIsPresented: Bool = false
    }
    
    enum Action {
        case reportMissingButtonDidTap
        case lectureCellDidTap
    }
    
    @Published var state = State()
    @Binding var viewType: TimeTableViewType
    @Published var lectureList: [LectureInfo] = [.stub, .stub, .stub, .stub, .stub]
    private let cancelBag = CancelBag()
    
    init(viewType: Binding<TimeTableViewType>) {
        self._viewType = viewType
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .reportMissingButtonDidTap:
            state.reportMissingModuleAlertIsPresented = true
        case .lectureCellDidTap:
            viewType = .main
            state.inValidregisterModuleIsPresented = true
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
}


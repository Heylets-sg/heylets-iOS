//
//  ThemeViewModel.swift
//  TimeTableFeature
//
//  Created by 류희재 on 1/7/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import DSKit
import Core

public class ThemeViewModel: ObservableObject {
    struct State {
        var isShowingSelectInfoView: Bool = false
    }
    
    enum Action {
        case onAppear
        case saveButtonDidTap
        case selectDisplayTypeButtonDidTap
        case selectDisplayType(String)
        case reportButtonDidTap
    }
    
    @Published var state = State()
    @Published var themeList: [Theme] = []
    private let useCase: TimeTableUseCaseType
    @Published var displayType: String = "module code"
    
    let options = [
        "module code",
        "module code, class room",
        "module code, class room, professor",
        "module code, professor"
    ]
    
    private let cancelBag = CancelBag()
    
    public init(useCase: TimeTableUseCaseType) {
        self.useCase = useCase
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getThemeList()
                .receive(on: RunLoop.main)
                .assign(to: \.themeList, on: self)
                .store(in: cancelBag)
            //TODO: 시간표 모듈 설정 API 호출
            
        case .saveButtonDidTap:
            break
            //TODO: 시간표 모듈 설정 API
            
        case .selectDisplayTypeButtonDidTap:
            state.isShowingSelectInfoView.toggle()
        case .selectDisplayType(let displayType):
            self.displayType = displayType
            state.isShowingSelectInfoView.toggle()
        case .reportButtonDidTap:
            print("report 버튼 누름")
            state.isShowingSelectInfoView = false
            
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
    }
}

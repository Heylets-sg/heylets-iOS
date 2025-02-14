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
import Domain
import DSKit
import Core

public class SearchModuleViewModel: ObservableObject {
    struct State {
        var selectedLecture: SectionInfo? = nil
    }
    
    enum Action {
        case onAppear
        case lectureCellDidTap(SectionInfo)
        case searchButtonDidTap
        case clearButtonDidTap
        case addLectureButtonDidTap(SectionInfo)
    }
    
    @Published var state = State()
    var selectLectureClosure: ((SectionInfo) -> Void)?
    var addLectureClosure: ((SectionInfo) -> Void)?
    @Published var lectureList: [SectionInfo] = []
    @Published var searchText = ""
    
    private let cancelBag = CancelBag()
    private let useCase: TimeTableUseCaseType
    
    public init(_ useCase: TimeTableUseCaseType) {
        self.useCase = useCase
    }
    
    func send(_ action: Action) {
        switch action {
        case .onAppear:
            useCase.getLectureList(searchText)
                .receive(on: RunLoop.main)
                .assign(to: \.lectureList, on: self)
                .store(in: cancelBag)
            
        case .lectureCellDidTap(let lecture):
            state.selectedLecture = lecture
            guard let selectLecture = selectLectureClosure else { return }
            selectLecture(lecture)
            
        case .searchButtonDidTap:
            useCase.getLectureList(searchText)
                .receive(on: RunLoop.main)
                .assign(to: \.lectureList, on: self)
                .store(in: cancelBag)
            
        case .clearButtonDidTap:
            searchText = ""
            state.selectedLecture = nil
            useCase.getLectureList(searchText)
                .receive(on: RunLoop.main)
                .assign(to: \.lectureList, on: self)
                .store(in: cancelBag)
            
        case .addLectureButtonDidTap(let lecture):
            guard let addLecture = addLectureClosure else { return }
            addLecture(lecture)
            state.selectedLecture = nil
        }
    }
}

